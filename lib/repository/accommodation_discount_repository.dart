import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_response_model.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class AccommodationDiscountRepository {
   final String _baseUrl = Environment.UrlApi;

  Future<api_response_list.ApiResponse<AccommodationDiscountResponseModel>> getbyAccommodation(int accommodationId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/accommodation_discounts/$accommodationId/accommodation'),
        headers: <String, String>{
          'Content-Discount': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationDiscountResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationDiscountsResponseModel.fromJsonList(data['data']).items,
        ); 
      } else {
        final data = json.decode(response.body); 
        return api_response_list.ApiResponse<AccommodationDiscountResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return api_response_list.ApiResponse<AccommodationDiscountResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationDiscountResponseModel>> createAccommodationDiscount(AccommodationDiscountRequestModel accommodation) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/accommodation_discounts'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(accommodation.toJson())  
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationDiscountResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationDiscountResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationDiscountResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationDiscountResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationDiscountResponseModel>> delete(int discountId) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.delete(
        Uri.parse('$_baseUrl/v1/accommodation_discounts/$discountId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationDiscountResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationDiscountResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationDiscountResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationDiscountResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

Future<ApiResponse<AccommodationDiscountResponseModel>> update(int id, AccommodationDiscountRequestModel accommodation) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      final response = await http.put(
        Uri.parse('$_baseUrl/v1/accommodation_discounts/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(accommodation.toJson())  
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationDiscountResponseModel>(
          status: true,
          message: data['message'],
          
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<AccommodationDiscountResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationDiscountResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }




  
}