import 'package:clima_certo_639/src/modules/auth/auth_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../models/requests/signup_request.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  final AuthService _authService = Modular.get<AuthService>();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String fullname = '';

  @observable
  String confirmPassword = '';

  @observable
  bool hasError = false;

  @observable
  String errorMessage = '';

  @observable
  String successMessage = '';

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;
  @action
  void setConfirmPassword(String value) => confirmPassword = value;
  @action
  void setfullname(String value) => fullname = value;

  @action
  void setErrorMessage(String value) => errorMessage = value;

  @action
  void setSuccessMessage(String value) => successMessage = value;

  @action
  void setHasError(bool value) {
    hasError = value;
    setErrorMessage('');
  }

  @action
  void resetForm() {
    setfullname('');
    setConfirmPassword('');
    setPassword('');
    setConfirmPassword('');
  }

  @action
  Future<void> signup() async {
    setHasError(false);
    setSuccessMessage('');

    try {
      await _authService.signup(
        new SignupRequest(
          email: email,
          password: password,
          fullname: fullname,
        ),
      );

      resetForm();
      setSuccessMessage('Cadastro realizado com sucesso.');
    } catch (e) {
      _handleError(e);
    }

    Modular.to.pop();
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

  pick(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      await signup();

      // implementar para poder armazenar foto para resgatar depois.
      //   imageFile = File(pickedFile.path);
    } else {
      setHasError(false);
      setErrorMessage(
        'Ocorreu um erro inesperado, não foi possível acesso a câmera.',
      );
    }
  }
}
