import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/service_response_model.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;

class ServiceRepository {
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<ServiceResponseModel>> get() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/services'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<ServiceResponseModel>(
          status: true,
          message: data['message'],
          data: ServicesResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<ServiceResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<ServiceResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }


  
}