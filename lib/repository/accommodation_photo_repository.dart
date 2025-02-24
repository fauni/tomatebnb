import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_response_model.dart';

import 'package:tomatebnb/models/response/api_response_list.dart' as api_response_list;
import 'package:tomatebnb/models/response/api_response.dart';

class AccommodationPhotoRepository {
   final String _baseUrl = Environment.UrlApi;

  // Future<api_response_list.ApiResponse<AccommodationPhotoResponseModel>> getbyAccommodation(int accommodationId) async {
  //   try{
  //     final prefs = await SharedPreferences.getInstance();
  //     String token = prefs.getString("token")??"";
  //     final response = await http.get(
  //       Uri.parse('$_baseUrl/v1/accommodation_aspects/$accommodationId/accommodation'),
  //       headers: <String, String>{
  //         'Content-Photo': 'application/json',
  //         'Accept' : 'application/json',
  //         'Authorization':'Bearer $token',
  //       }
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body); 
  //       return api_response_list.ApiResponse<AccommodationPhotoResponseModel>(
  //         status: true,
  //         message: data['message'],
  //         data: AccommodationPhotosResponseModel.fromJsonList(data['data']).items,
  //       ); 
  //     } else {
  //       final data = json.decode(response.body); 
  //       return api_response_list.ApiResponse<AccommodationPhotoResponseModel>(
  //         status: false,
  //         message: data['message']
  //       ); 
  //     }
  //   } catch (e) {
  //     return api_response_list.ApiResponse<AccommodationPhotoResponseModel>(
  //       status: false, 
  //       message: e.toString()
  //     );
  //   }
  // }

Future<ApiResponse<AccommodationPhotoResponseModel>> createAccommodationPhoto(AccommodationPhotoRequestModel photo, File file) async {
    try{

      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      
      var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/v1/accommodation_photos/upload'));
      
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['accommodation_id'] = photo.accommodationId;
      request.fields['photo_url'] = photo.photoUrl;
      request.fields['mainPhoto'] = photo.mainPhoto;
      request.fields['order'] = photo.order;
      request.files.add(http.MultipartFile.fromBytes('image',File(file!.path).readAsBytesSync(),filename: file!.path));
      

      final response = await request.send();

      if (response.statusCode == 200) {
        final data = json.decode((await http.Response.fromStream(response)).body); 
        return ApiResponse<AccommodationPhotoResponseModel>(
          status: true,
          message: data['message'],
          data: AccommodationPhotoResponseModel.fromJson(data['data']),
        ); 
      } else {
        final data = json.decode((await http.Response.fromStream(response)).body); 
        return ApiResponse<AccommodationPhotoResponseModel>(
          status: false,
          message: data['message']
        ); 
      }
    } catch (e) {
      return ApiResponse<AccommodationPhotoResponseModel>(
        status: false, 
        message: e.toString()
      );
    }
  }

// Future<ApiResponse<AccommodationPhotoResponseModel>> delete(int accommodationId, int aspectId) async {
//     try{
//       final prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString("token")??"";
//       final response = await http.delete(
//         Uri.parse('$_baseUrl/v1/accommodation_aspects/$accommodationId/$aspectId'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Accept' : 'application/json',
//           'Authorization':'Bearer $token',
//         }
//       );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body); 
//         return ApiResponse<AccommodationPhotoResponseModel>(
//           status: true,
//           message: data['message'],
//           data: AccommodationPhotoResponseModel.fromJson(data['data']),
//         ); 
//       } else {
//         final data = json.decode(response.body); 
//         return ApiResponse<AccommodationPhotoResponseModel>(
//           status: false,
//           message: data['message']
//         ); 
//       }
//     } catch (e) {
//       return ApiResponse<AccommodationPhotoResponseModel>(
//         status: false, 
//         message: e.toString()
//       );
//     }
//   }



  
}