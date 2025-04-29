import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/user/user_request_model.dart';
import 'package:tomatebnb/models/user/user_response_model.dart';
import 'package:tomatebnb/models/response/api_response.dart';

class UserRepository {
  final String _baseUrl = Environment.UrlApi;

Future<void> setUserData(UserResponseModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id!);
    await prefs.setString('email', user.email!);
    await prefs.setString('name', user.name!);
    await prefs.setString('profilePhoto', user.profilePhoto??"");
    await prefs.setString('profilePhotoUrl', user.profilePhotoUrl??"");
  }

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
      final response = await http.put(Uri.parse('$_baseUrl/v1/users/$id'),
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

Future<ApiResponse<UserResponseModel>> updateUserPhoto(String column, File file) async {
  try{
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")??"";
    int userId = prefs.getInt("userId")??0;
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/v1/users/upload/$userId'));
    
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.fields['column'] = column;
    request.files.add(http.MultipartFile.fromBytes('image',File(file!.path).readAsBytesSync(),filename: file!.path));
    

    final response = await request.send();

    if (response.statusCode == 200) {
      final data = json.decode((await http.Response.fromStream(response)).body); 
      return ApiResponse<UserResponseModel>(
        status: true,
        message: data['message'],
        data: UserResponseModel.fromJson(data['data']),
      ); 
    } else {
      final data = json.decode((await http.Response.fromStream(response)).body); 
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

Future<ApiResponse<UserResponseModel>> updatePassword(String password) async {
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
        body:jsonEncode(<String,dynamic>{
          "password":password
        })  
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