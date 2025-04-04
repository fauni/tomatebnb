import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/describe_response_model.dart';
import 'package:tomatebnb/models/explore/describe.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/response_list.dart';

class DescribeRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<DescribeResponseModel>> getByUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/describes'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<DescribeResponseModel>(
          status: true,
          message: data['message'],
          data: DescribesResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<DescribeResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<DescribeResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<ApiResponseList<Describe>> handleGetDescribesForExplore() async {
    final url = Uri.parse('$_baseUrl/v1/explore/describes');  
    final prefs = await SharedPreferences.getInstance();
    
    String token = prefs.getString("token") ?? "";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        return ApiResponseList<Describe>.fromJson(data, (json) => Describe.fromJson(json));
      } else {
        final data = json.decode(response.body);
        return ApiResponseList<Describe>(
          status: false,
          message: data['message'],
          data: [],
        );
      }
    } catch (e) {
      return ApiResponseList<Describe>(
        status: false,
        message: e.toString(),
        data: [],
      );
    } 


  }
  
}