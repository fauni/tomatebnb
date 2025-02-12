import 'package:http/http.dart' as http;
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/login_response_model.dart';

class AuthRepository {
  final String _baseUrl = Environment.UrlApi;

  Future<LoginResponse> login(String email, String password) async {
    try{
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = loginResponseFromJson(response.body);
        return data;
      } else {
        // Responder el error;
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      // Manejo de excepciones para errores de red u otros
      return Future.error('Error al iniciar sesión');
    }
  }
}