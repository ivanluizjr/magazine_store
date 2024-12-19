import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magazine_store/app/core/services/config/environment.dart';
import 'package:magazine_store/app_module.dart';
import 'package:magazine_store/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  String environment = const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );
  Environment().initiConfig(environment);

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
