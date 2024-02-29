import 'package:clima_certo_639/src/app_module.dart';
import 'package:clima_certo_639/src/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then((_) {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(
      ModularApp(module: AppModule(), child: const AppWidget()),
    );
  });
}
