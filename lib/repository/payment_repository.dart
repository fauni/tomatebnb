
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/payment/url_response_payment.dart';
import 'package:tomatebnb/models/response/api_response.dart';

class PaymentRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<ApiResponse<UrlResponsePayment>> getUrlPayment(int idReserva) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/payment/generate/$idReserva'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiResponse<UrlResponsePayment>( 
          status: true,
          message: data['message'],
          data: UrlResponsePayment.fromJson(data['data']),
        );
      } else {
        final data = json.decode(response.body);
        return ApiResponse<UrlResponsePayment>(
          status: false,
          message: data['message'],
        );
      }
    } catch (e) {
      return ApiResponse<UrlResponsePayment>(
        status: false,
        message: e.toString(),
      );
    }
  }
}