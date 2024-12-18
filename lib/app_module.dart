import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magazine_store/app/core/routes/app_routes.dart';
import 'package:magazine_store/app/core/services/config/environment.dart';
import 'package:magazine_store/app/modules/products/products_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {
    i.addInstance(
      Dio(
        BaseOptions(baseUrl: Environment().config.apiHost),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.module(
      AppRoutes.initialRoute,
      module: ProductsModule(),
    );
  }
}
