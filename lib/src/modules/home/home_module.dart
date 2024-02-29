import 'package:clima_certo_639/src/helpers/dio_configuration.dart';
import 'package:clima_certo_639/src/modules/home/home_services.dart';
import 'package:clima_certo_639/src/modules/home/stores/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:clima_certo_639/src/modules/home/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(DioConfiguration.configureDio);
    i.addSingleton(HomeService.new);
    i.addSingleton(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
  }
}
