import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_rule_response_model.dart';

import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class AccommodationRuleRepository {
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<AccommodationRuleResponseModel>> getbyAccommodation(int accommodationId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/accommodation_rules/$accommodationId/accommodation'),
        headers: <String, String>{
          'Content-Rule': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationRuleResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationRulesResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationRuleResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<AccommodationRuleResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }


 Future<ApiResponse<AccommodationRuleResponseModel>> update(int id, AccommodationRuleRequestModel rule) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      // int userId = prefs.getInt("userId")??0;
      final response = await http.put(
        Uri.parse('$_baseUrl/v1/accommodation_rules/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(rule.toJson())
        
        // jsonEncode(<String,dynamic>{
        //   'description' : description,
        //   'title' : title,
        // }
        //)
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationRuleResponseModel>(
          status: true,
          message: data['message'],
          
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationRuleResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationRuleResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationRuleResponseModel>> createAccommodationRule(AccommodationRuleRequestModel rule) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/accommodation_rules'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode (rule.toJson() )
        // jsonEncode(<String,dynamic>{
        //   'accommodation_id' : accommodationId,
        //   'description' : description,
        //   'title':title
        // }) 
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationRuleResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationRuleResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationRuleResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationRuleResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }


Future<ApiResponse<AccommodationRuleResponseModel>> delete(int ruleId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.delete(
        Uri.parse('$_baseUrl/v1/accommodation_rules/$ruleId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationRuleResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationRuleResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationRuleResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationRuleResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }




}