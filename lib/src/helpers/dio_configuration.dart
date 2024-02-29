import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioConfiguration {
  static Dio configureDio() {
    final dio = Dio();
    final FlutterSecureStorage _secureStorage =
        Modular.get<FlutterSecureStorage>();

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    dio.options.baseUrl = 'https://localhost:44301/api';
    dio.options.headers['Content-Type'] = 'application/json';

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _secureStorage.read(key: 'token');

        // Adiciona o token JWT ao cabeçalho de autorização
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        options.validateStatus = (status) {
          return status! >= 200 && status < 300;
        };
        options.receiveTimeout = Duration(seconds: 5000);
        options.connectTimeout = Duration(seconds: 5000);
        handler.next(options);
      },
    ));

    return dio;
  }
}
