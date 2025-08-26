import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/auth/login_response_model.dart';
import 'package:tomatebnb/models/response/api_response.dart';
import 'package:tomatebnb/models/user/user_request_modelp.dart';
import 'package:tomatebnb/models/user/user_response_model.dart';

class AuthRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<void> setUserData(LoginResponseModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id!);
    await prefs.setString('email', user.email!);
    await prefs.setString('name', user.name!);
    await prefs.setString('token', user.token!);
    await prefs.setString('tokenType', user.tokenType!);
    await prefs.setString('profilePhoto', user.profilePhoto??"");
    await prefs.setString('profilePhotoUrl', user.profilePhotoUrl??"");
  }

  Future<void> clearUsarData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('token');
    await prefs.remove('tokenType');
    await prefs.remove('profilePhoto');
    await prefs.remove('profilePhotoUrl');
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

   Future<ApiResponse<UserResponseModel>> create(UserRequestModelp user) async {
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name':user.name??'',
          'lastname': user.lastname??'',
          'email': user.email??'',
          'password': user.password??'',

        }
        )
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

  Future<ApiResponse<UserResponseModel>> createVerificationCode(String email) async {
    try{   
      final response = await http.post(
        Uri.parse('$_baseUrl/verification'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json'
        },
        body:jsonEncode(
          <String, String>{
            'email': email,
          }
        )  
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

  //verificar el codigo de verificacion
  Future<ApiResponse<UserResponseModel>> verificateCode(String code, String email) async {
    try{   
      final response = await http.post(
        Uri.parse('$_baseUrl/verificate'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json'
        },
        body:jsonEncode(
          <String, String>{
            'code': code,
            'email': email
          }
        )  
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
  Future<ApiResponse<String>> sendResetLink(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/password/email'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept' : 'application/json'
        },
        body: jsonEncode(<String, String>{
          'email': email,
        })
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body); 
        return ApiResponse<String>(
          status: true,
          message: data['message']
        ); 
      } else {
        final data = json.decode(response.body); 
        return ApiResponse<String>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<String>(
        status: false, 
        message: e.toString()
      );
    }
  }
}