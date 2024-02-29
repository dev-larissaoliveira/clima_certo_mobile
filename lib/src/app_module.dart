import 'package:clima_certo_639/src/helpers/dio_configuration.dart';
import 'package:clima_certo_639/src/modules/auth/auth_module.dart';
import 'package:clima_certo_639/src/modules/auth/auth_services.dart';
import 'package:clima_certo_639/src/modules/auth/pages/login_page.dart';
import 'package:clima_certo_639/src/modules/auth/stores/login/login_store.dart';
import 'package:clima_certo_639/src/modules/auth/stores/signup/signup_store.dart';
import 'package:clima_certo_639/src/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(DioConfiguration.configureDio);
    i.addSingleton(FlutterSecureStorage.new);
    i.addSingleton(AuthService.new);
    i.addSingleton(LoginStore.new);
    i.addSingleton(SignupStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const LoginPage());

    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
