import 'package:clima_certo_639/src/modules/auth/auth_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthService _authService = Modular.get<AuthService>();
  final FlutterSecureStorage _secureStorage =
      Modular.get<FlutterSecureStorage>();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool saveCredentials = false;

  @observable
  bool hasError = false;

  @observable
  String errorMessage = '';

  @observable
  String? tokenAuth;

  @observable
  bool loggedIn = false;

  @observable
  bool loading = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setSaveCredentials(bool value) => saveCredentials = value;

  @action
  void setErrorMessage(String value) => errorMessage = value;

  @action
  void setHasError(bool value) {
    hasError = value;
    setErrorMessage('');
  }

  @action
  void setLoggedIn(bool value) => loggedIn = value;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> login() async {
    setHasError(false);
    setLoggedIn(false);
    setLoading(true);

    try {
      var result = await _authService.login(email, password);

      if (result.token.isNotEmpty) {
        await saveToken(result.token);
        setLoggedIn(true);

        navigateToLoggedInArea();
      } else {
        setHasError(true);
        setErrorMessage("Ocorreu um erro inesperado");
      }
    } catch (e) {
      _handleError(e);
    }

    setLoading(false);
  }

  void navigateToLoggedInArea() {
    Modular.to.pushReplacementNamed('/home');
  }

  void logout() {
    // Limpa o token armazenado de forma segura
    deleteToken();

    // Reseta o estado de autenticação para não autenticado
    setLoggedIn(false);

    Modular.to.pushReplacementNamed('/login');
  }

  @action
  Future<void> loadRememberedPassword() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @action
  Future<void> saveRememberedPassword() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @action
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
    this.tokenAuth = token;
  }

  @action
  Future<void> loadToken() async {
    tokenAuth = await _secureStorage.read(key: 'token');
  }

  @action
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'token');
    tokenAuth = null;
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
      msg = error ?? 'Ocorreu um erro inesperado.';
    }

    setErrorMessage(msg);
  }
}
