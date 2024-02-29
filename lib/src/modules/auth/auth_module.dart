import 'package:clima_certo_639/src/modules/auth/pages/login_page.dart';
import 'package:clima_certo_639/src/modules/auth/pages/signup_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/login', child: (_) => const LoginPage());
    r.child('/signup', child: (_) => const SignupPage());
  }
}
