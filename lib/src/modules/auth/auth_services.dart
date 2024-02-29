import 'package:clima_certo_639/src/modules/auth/models/requests/login_request.dart';
import 'package:clima_certo_639/src/modules/auth/models/responses/login_response.dart';
import 'package:clima_certo_639/src/modules/auth/models/requests/signup_request.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<LoginResponse> login(String email, String password) async {
    try {
      final loginRequest = LoginRequest(email: email, password: password);

      final response =
          await _dio.post('/Authentication/login', data: loginRequest);

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw ApiException.fromJson(response.data);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> signup(SignupRequest request) async {
    try {
      final response = await _dio.post('/User', data: request);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw ApiException.fromJson(response.data);
      }
    } catch (e) {
      throw e;
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromJson(Map<String, dynamic> json) {
    return ApiException(json['error']);
  }
}
