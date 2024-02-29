import 'package:clima_certo_639/src/modules/home/home_services.dart';
import 'package:clima_certo_639/src/modules/home/models/responses/weather_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:geolocator/geolocator.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final HomeService _homeService = Modular.get<HomeService>();

  @observable
  bool hasError = false;

  @observable
  String errorMessage = '';

  @observable
  WeatherResponse? weatherData;

  @action
  void setErrorMessage(String value) => errorMessage = value;

  @action
  void setWeatherData(WeatherResponse value) => weatherData = value;

  @action
  void setHasError(bool value) {
    hasError = value;
    setErrorMessage('');
  }

  @action
  Future<void> fetchWeatherData() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Se a permissão não foi concedida, solicite ao usuário
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Se a permissão não foi concedida pelo usuário, retorne sem fazer nada
          return;
        }
      }

      // Obtenha a posição atual do dispositivo
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Extraia a latitude e a longitude da posição
      double latitude = position.latitude;
      double longitude = position.longitude;

      WeatherResponse weatherData =
          await _homeService.getWeather(latitude, longitude);

      setWeatherData(weatherData);
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(error) {
    String msg = "";
    setHasError(true);

    if (error is DioException) {
      if (error.response != null) {
        if (error.response!.data.containsKey('Message') &&
            error.response!.data['Message'] != null) {
          msg = error.response!.data['Message'];
        }
      } else {
        msg = 'Ocorreu um erro inesperado.';
      }
    } else {
      msg = 'Ocorreu um erro inesperado.';
    }

    setErrorMessage(msg);
  }
}
