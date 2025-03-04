import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/user/user_request_model.dart';
import 'package:tomatebnb/models/user/user_response_model.dart';
import 'package:tomatebnb/models/response/api_response.dart';

class UserRepository {
  final String _baseUrl = Environment.UrlApi;


  Future<ApiResponse<UserResponseModel>> getUser() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      int id = prefs.getInt("userId")??0;
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/users/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<UserResponseModel>(
          status: true,
          message: data['message'],
          data: UserResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<UserResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<UserResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

 Future<ApiResponse<UserResponseModel>> update(UserRequestModel user) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      int id = prefs.getInt("userId")??0;
      final response = await http.put(
        Uri.parse('$_baseUrl/v1/users/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json',
          'Authorization':'Bearer $token',
        },
        body:jsonEncode(user.toJson())  
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<UserResponseModel>(
          status: true,
          message: data['message'],
          
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<UserResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<UserResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }



}