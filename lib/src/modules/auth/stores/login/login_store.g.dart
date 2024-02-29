// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  late final _$emailAtom =
      Atom(name: '_LoginStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$saveCredentialsAtom =
      Atom(name: '_LoginStoreBase.saveCredentials', context: context);

  @override
  bool get saveCredentials {
    _$saveCredentialsAtom.reportRead();
    return super.saveCredentials;
  }

  @override
  set saveCredentials(bool value) {
    _$saveCredentialsAtom.reportWrite(value, super.saveCredentials, () {
      super.saveCredentials = value;
    });
  }

  late final _$hasErrorAtom =
      Atom(name: '_LoginStoreBase.hasError', context: context);

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
      Atom(name: '_LoginStoreBase.errorMessage', context: context);

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

  late final _$tokenAuthAtom =
      Atom(name: '_LoginStoreBase.tokenAuth', context: context);

  @override
  String? get tokenAuth {
    _$tokenAuthAtom.reportRead();
    return super.tokenAuth;
  }

  @override
  set tokenAuth(String? value) {
    _$tokenAuthAtom.reportWrite(value, super.tokenAuth, () {
      super.tokenAuth = value;
    });
  }

  late final _$loggedInAtom =
      Atom(name: '_LoginStoreBase.loggedIn', context: context);

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_LoginStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginStoreBase.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$loadRememberedPasswordAsyncAction =
      AsyncAction('_LoginStoreBase.loadRememberedPassword', context: context);

  @override
  Future<void> loadRememberedPassword() {
    return _$loadRememberedPasswordAsyncAction
        .run(() => super.loadRememberedPassword());
  }

  late final _$saveRememberedPasswordAsyncAction =
      AsyncAction('_LoginStoreBase.saveRememberedPassword', context: context);

  @override
  Future<void> saveRememberedPassword() {
    return _$saveRememberedPasswordAsyncAction
        .run(() => super.saveRememberedPassword());
  }

  late final _$saveTokenAsyncAction =
      AsyncAction('_LoginStoreBase.saveToken', context: context);

  @override
  Future<void> saveToken(String token) {
    return _$saveTokenAsyncAction.run(() => super.saveToken(token));
  }

  late final _$loadTokenAsyncAction =
      AsyncAction('_LoginStoreBase.loadToken', context: context);

  @override
  Future<void> loadToken() {
    return _$loadTokenAsyncAction.run(() => super.loadToken());
  }

  late final _$deleteTokenAsyncAction =
      AsyncAction('_LoginStoreBase.deleteToken', context: context);

  @override
  Future<void> deleteToken() {
    return _$deleteTokenAsyncAction.run(() => super.deleteToken());
  }

  late final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSaveCredentials(bool value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setSaveCredentials');
    try {
      return super.setSaveCredentials(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasError(bool value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setHasError');
    try {
      return super.setHasError(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoggedIn(bool value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setLoggedIn');
    try {
      return super.setLoggedIn(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
saveCredentials: ${saveCredentials},
hasError: ${hasError},
errorMessage: ${errorMessage},
tokenAuth: ${tokenAuth},
loggedIn: ${loggedIn},
loading: ${loading}
    ''';
  }
}
