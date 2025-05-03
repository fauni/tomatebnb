import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_filter_request.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';
import 'package:tomatebnb/models/response/response_list.dart';

class AccommodationRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<ApiResponseList<AccommodationResponseCompleteModel>> filterAccommodations(AccommodationFilterRequest request) async{
    final url = Uri.parse('$_baseUrl/v1/accommodations/filter2');
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token")??"";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
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
      return ApiResponseList(status: false, message: e.toString());
    }
  }

  Future<api_response_list.ApiResponse<AccommodationResponseCompleteModel>> getByUser() async {
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
        return api_response_list.ApiResponse<AccommodationResponseCompleteModel>(
          status: true,
          message: data['message'],
          data: AccommodationsResponseCompleteModel.fromJsonList(data['data']).items,
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

  Future<ApiResponse<AccommodationResponseCompleteModel>> getByIdComplete(int id) async {
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


 Future<ApiResponse<AccommodationResponseModel>> publish(int id,double priceNight,bool publish) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      int userId = prefs.getInt("userId")??0;
      final response = await http.put(
        Uri.parse('$_baseUrl/v1/accommodations/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(<String,dynamic>{
          'price_night' : priceNight,
          'published' : publish,
          'host_id' : userId
        })
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