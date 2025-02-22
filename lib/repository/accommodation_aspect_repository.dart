import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_aspect_response_model.dart';

import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class AccommodationAspectRepository {
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<AccommodationAspectResponseModel>> getbyAccommodation(int accommodationId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/accommodation_aspects/$accommodationId/accommodation'),
        headers: <String, String>{
          'Content-Aspect': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationAspectResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationAspectsResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationAspectResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<AccommodationAspectResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationAspectResponseModel>> createAccommodationAspect(int accommodationId, int aspectId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/accommodation_aspects'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(<String,dynamic>{
          'accommodation_id' : accommodationId,
          'aspect_id' : aspectId,
          'status':true
        }) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationAspectResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationAspectResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationAspectResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationAspectResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationAspectResponseModel>> delete(int accommodationId, int serviceId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.delete(
        Uri.parse('$_baseUrl/v1/accommodation_services/$accommodationId/$serviceId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationAspectResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationAspectResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationAspectResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationAspectResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }



  
}