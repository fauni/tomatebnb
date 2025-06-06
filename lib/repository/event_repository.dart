import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/reserve/event_request_model.dart';
import 'package:tomatebnb/models/reserve/event_response_model.dart';

import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class EventRepository {
  final String _baseUrl = Environment.UrlApi;

  // Future<ApiResponse<EventResponseModel>> getEventById(int id) async {
  //   try{
  //     final prefs = await SharedPreferences.getInstance();
  //     String token = prefs.getString("token")??"";
  //     final response = await http.get(
  //       Uri.parse('$_baseUrl/v1/reserves/$id'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept' : 'application/json',
  //         'Authorization':'Bearer $token',
  //       }
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body); 
  //       return ApiResponse<EventResponseModel>(
  //         status: true,
  //         message: data['message'],
  //         data: EventResponseModel.fromJson(data['data']),
  //       ); 
  //     } else {
  //       final data = json.decode(response.body); 
  //       return ApiResponse<EventResponseModel>(
  //         status: false,
  //         message: data['message']
  //       ); 
  //     }
  //   } catch (e) {
  //     return ApiResponse<EventResponseModel>(
  //       status: false, 
  //       message: e.toString()
  //     );
  //   }
  // }

  // Future<api_response_list.ApiResponse<EventResponseModel>> getbyAccommodation(int accommodationId) async {
  //   try{
  //     final prefs = await SharedPreferences.getInstance();
  //     String token = prefs.getString("token")??"";
  //     final response = await http.get(
  //       Uri.parse('$_baseUrl/v1/reserves/$accommodationId/accommodation'),
  //       headers: <String, String>{
  //         'Content-Service': 'application/json',
  //         'Accept' : 'application/json',
  //         'Authorization':'Bearer $token',
  //       }
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body); 
  //       return api_response_list.ApiResponse<EventResponseModel>(
  //         status: true,
  //         message: data['message'],
  //         data: EventsResponseModel.fromJsonList(data['data']).items,
  //       ); 
  //     } else {
  //       final data = json.decode(response.body); 
  //       return api_response_list.ApiResponse<EventResponseModel>(
  //         status: false,
  //         message: data['message']
  //       ); 
  //     }
  //   } catch (e) {
  //     return api_response_list.ApiResponse<EventResponseModel>(
  //       status: false, 
  //       message: e.toString()
  //     );
  //   }
  // }

Future<ApiResponse<EventResponseModel>> createEvent(EventRequestModel event) async {
    try{

      final prefs = await SharedPreferences.getInstance();
      // int userId = prefs.getInt("userId")??0;
      // reserve.userId = userId;
      // reserve.status = true;
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/events'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(event.toJson()) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<EventResponseModel>(
          status: true,
          message: data['message'],
          data: EventResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<EventResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<EventResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  
  Future<api_response_list.ApiResponse<EventResponseModel>> getByReserve(reserveId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      // int userId = prefs.getInt("userId")??0;
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/events/$reserveId/reserve'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<EventResponseModel>(
          status: true,
          message: data['message'],
          data: EventsResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<EventResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<EventResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

  // Future<ApiResponse<EventResponseModel>> check(int reserveId,String checkDate, String column) async {
  //   try{
  //     final prefs = await SharedPreferences.getInstance();
  //     String token = prefs.getString("token")??"";
  //     final response = await http.put(
  //       Uri.parse('$_baseUrl/v1/reserves/$reserveId'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Accept' : 'application/json',
  //         'Authorization':'Bearer $token',
  //       },
  //       body:jsonEncode({
  //         column: checkDate
  //       }) 
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body); 
  //       return ApiResponse<EventResponseModel>(
  //         status: true,
  //         message: data['message'],
  //         // data: EventResponseModel.fromJson(data['data']),
  //       ); 
  //     } else {
  //       final data = json.decode(response.body); 
  //       return ApiResponse<EventResponseModel>(
  //         status: false,
  //         message: data['message']
  //       ); 
  //     }
  //   } catch (e) {
  //     return ApiResponse<EventResponseModel>(
  //       status: false, 
  //       message: e.toString()
  //     );
  //   }
  // }
 
}