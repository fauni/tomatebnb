import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class AccommodationRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<AccommodationResponseModel>> getByUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      int hostId = prefs.getInt("userId")??0;
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/accommodations/$hostId/user'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationsResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<AccommodationResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<ApiResponse<AccommodationResponseModel>> createAd() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      int hostId = prefs.getInt("userId")??0;
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/accommodations'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(<String,int>{
          'host_id' : hostId,
        }) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<ApiResponse<AccommodationResponseModel>> getById(int id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/accommodations/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

 Future<ApiResponse<AccommodationResponseModel>> update(int id, AccommodationRequestModel accommodation) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.put(
        Uri.parse('$_baseUrl/v1/accommodations/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(accommodation.toJson())  
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseModel>(
          status: true,
          message: data['message'],
          
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }



}