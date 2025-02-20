import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_service_response_model.dart';

import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class AccommodationServiceRepository {
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<AccommodationServiceResponseModel>> getbyAccommodation(int accommodationId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/accommodation_services/$accommodationId/accommodation'),
        headers: <String, String>{
          'Content-Service': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationServiceResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationServicesResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationServiceResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<AccommodationServiceResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationServiceResponseModel>> createAccommodationService(int accommodationId, int serviceId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/accommodation_services'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(<String,dynamic>{
          'accommodation_id' : accommodationId,
          'service_id' : serviceId,
          'status':true
        }) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationServiceResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationServiceResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationServiceResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationServiceResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationServiceResponseModel>> delete(int accommodationId, int serviceId) async {
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
        return ApiResponse<AccommodationServiceResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationServiceResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationServiceResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationServiceResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }



  
}