import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/models/reserve/reserve_request_model.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class ReserveRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<ApiResponse<ReserveResponseModel>> getReserveById(int id) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/reserves/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<ReserveResponseModel>(
          status: true,
          message: data['message'],
          data: ReserveResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<ReserveResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<ReserveResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<api_response_list.ApiResponse<ReserveResponseModel>> getbyAccommodation(int accommodationId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/reserves/$accommodationId/accommodation'),
        headers: <String, String>{
          'Content-Service': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<ReserveResponseModel>(
          status: true,
          message: data['message'],
          data: ReservesResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<ReserveResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<ReserveResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<ReserveResponseModel>> createReserve(ReserveRequestModel reserve) async {
    try{

      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("userId")??0;
      reserve.userId = userId;
      reserve.status = true;
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/reserves'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(reserve.toJson()) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<ReserveResponseModel>(
          status: true,
          message: data['message'],
          data: ReserveResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<ReserveResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<ReserveResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  
  Future<api_response_list.ApiResponse<ReserveResponseModel>> getByUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("userId")??0;
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/reserves/$userId/user'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<ReserveResponseModel>(
          status: true,
          message: data['message'],
          data: ReservesResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<ReserveResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<ReserveResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  Future<ApiResponse<ReserveResponseModel>> check(int reserveId,String checkDate, String column) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.put(
        Uri.parse('$_baseUrl/v1/reserves/$reserveId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode({
          column: checkDate
        }) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<ReserveResponseModel>(
          status: true,
          message: data['message'],
          // data: ReserveResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<ReserveResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<ReserveResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }
 
}