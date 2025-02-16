import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/auth/login_response_model.dart';
import 'package:tomatebnb/models/response/api_response.dart';

class AuthRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<void> setUserData(LoginResponseModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id!);
    await prefs.setString('email', user.email!);
    await prefs.setString('name', user.name!);
    await prefs.setString('token', user.token!);
    await prefs.setString('tokenType', user.tokenType!);
  }

  Future<void> clearUsarData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('token');
    await prefs.remove('tokenType');
  }

  Future<ApiResponse<LoginResponseModel>> login(String email, String password) async {
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password
        })
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<LoginResponseModel>(
          status: true,
          message: data['message'],
          data: LoginResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<LoginResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<LoginResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }
}