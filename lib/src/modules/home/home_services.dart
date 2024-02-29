import 'package:clima_certo_639/src/modules/home/models/responses/weather_response.dart';
import 'package:dio/dio.dart';

class HomeService {
  final Dio _dio;

  HomeService(this._dio);

  Future<WeatherResponse> getWeather(double lat, double long) async {
    try {
      Map<String, dynamic> queryParams = {
        'latitude': lat,
        'longitude': long,
      };

      final response = await _dio.get('/Weather', queryParameters: queryParams);

      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(response.data);
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
