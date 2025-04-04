
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/response/api_response.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/response_list.dart';


class ExploreRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<ApiResponse<AccommodationResponseCompleteModel>> getAccommodationById(int id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/explore/accommodation/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseCompleteModel>(
          status: true,
          message: data['message'],
          data: AccommodationResponseCompleteModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseCompleteModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationResponseCompleteModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<ApiResponseList<AccommodationResponseCompleteModel>> getAccommodationByDescribe(int describeId) async {
    final url = Uri.parse('$_baseUrl/v1/explore/accommodation/describe/$describeId');
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token")??"";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        return ApiResponseList<AccommodationResponseCompleteModel>.fromJson(data, (json) => AccommodationResponseCompleteModel.fromJson(json));
      } else {
        final data = json.decode(response.body);
        return ApiResponseList<AccommodationResponseCompleteModel>(
          status: false,
          message: data['message']
        );
      }
    } catch (e) {
      return ApiResponseList<AccommodationResponseCompleteModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<api_response_list.ApiResponse<AccommodationResponseCompleteModel>> getAccommodationNearby() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final url = Uri.parse('$_baseUrl/v1/explore/accommodation/nearby');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if(response.statusCode == 200){
        final data = json.decode(response.body);

        final List<AccommodationResponseCompleteModel> accommodationsData = (data['data'] as List)
          .map((item) => AccommodationResponseCompleteModel
          .fromJson(item))
          .toList();

        return api_response_list.ApiResponse<AccommodationResponseCompleteModel>(
          status: true,
          message: data['message'],
          data: accommodationsData
        );

      } else {
        final data = json.decode(response.body);
        return api_response_list.ApiResponse<AccommodationResponseCompleteModel>(
          status: false,
          message: data['message']
        );
      }
    } catch (e) {
      return api_response_list.ApiResponse<AccommodationResponseCompleteModel>(
        status: false, 
        message: e.toString()
      );
    }
  }
}