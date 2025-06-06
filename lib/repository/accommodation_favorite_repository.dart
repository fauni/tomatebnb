import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/explore/favorite.dart';
import 'package:tomatebnb/models/response/response_list.dart';

import '../models/response/api_response.dart';

class AccommodationFavoriteRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<ApiResponseList<AccommodationResponseCompleteModel>> getAccommodationFavorites() async {
    final url = Uri.parse('$_baseUrl/v1/favorites');
    final prefs = await SharedPreferences.getInstance();
    
    String token = prefs.getString("token") ?? "";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponseList<AccommodationResponseCompleteModel>.fromJson(
          data, (json) => AccommodationResponseCompleteModel.fromJson(json));
      } else {
        final data = json.decode(response.body);
        return ApiResponseList<AccommodationResponseCompleteModel>(
            status: false, message: data['message']);
      }
    } catch (e) {
      return ApiResponseList<AccommodationResponseCompleteModel>(
          status: false, message: e.toString());
    }
  }

  Future<ApiResponse<Favorite>> addAccommodationFavorite(int accommodationId) async {
    final url = Uri.parse('$_baseUrl/v1/favorites');
    final prefs = await SharedPreferences.getInstance();
    
    String token = prefs.getString("token") ?? "";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'accommodation_id': accommodationId,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return ApiResponse<Favorite>(status: true, message: data['message']);
      } else {
        final data = json.decode(response.body);
        return ApiResponse<Favorite>(status: false, message: data['message']);
      }
    } catch (e) {
      return ApiResponse<Favorite>(status: false, message: e.toString());
    }
  }

  Future<ApiResponse<Favorite>> removeAccommodationFavorite(int accommodationId) async {
    final url = Uri.parse('$_baseUrl/v1/favorites/remove');
    final prefs = await SharedPreferences.getInstance();
    
    String token = prefs.getString("token") ?? "";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'accommodation_id': accommodationId,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponse<Favorite>(status: true, message: data['message']);
      } else {
        final data = json.decode(response.body);
        return ApiResponse<Favorite>(status: false, message: data['message']);
      }
    } catch (e) {
      return ApiResponse<Favorite>(status: false, message: e.toString());
    }
  }
}