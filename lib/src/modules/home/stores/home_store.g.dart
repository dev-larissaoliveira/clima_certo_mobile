// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$hasErrorAtom =
      Atom(name: '_HomeStoreBase.hasError', context: context);

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_HomeStoreBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$weatherDataAtom =
      Atom(name: '_HomeStoreBase.weatherData', context: context);

  @override
  WeatherResponse? get weatherData {
    _$weatherDataAtom.reportRead();
    return super.weatherData;
  }

  @override
  set weatherData(WeatherResponse? value) {
    _$weatherDataAtom.reportWrite(value, super.weatherData, () {
      super.weatherData = value;
    });
  }

  late final _$fetchWeatherDataAsyncAction =
      AsyncAction('_HomeStoreBase.fetchWeatherData', context: context);

  @override
  Future<void> fetchWeatherData() {
    return _$fetchWeatherDataAsyncAction.run(() => super.fetchWeatherData());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void setErrorMessage(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeatherData(WeatherResponse value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setWeatherData');
    try {
      return super.setWeatherData(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError(bool value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setHasError');
    try {
      return super.setHasError(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasError: ${hasError},
errorMessage: ${errorMessage},
weatherData: ${weatherData}
    ''';
  }
}
