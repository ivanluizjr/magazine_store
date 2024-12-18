import 'package:flutter_modular/flutter_modular.dart';
import 'package:magazine_store/app/core/dio_cliient/dio/dio_client_service_impl.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_client_service.dart';
import 'package:magazine_store/app/core/services/shared_preferences_service.dart';
import 'package:magazine_store/app/modules/products/data/datasources/impl/products_datasource_impl.dart';
import 'package:magazine_store/app/modules/products/data/datasources/products_datasource.dart';
import 'package:magazine_store/app/modules/products/data/repositories/products_repository_impl.dart';
import 'package:magazine_store/app/modules/products/domain/repositories/products_repository.dart';
import 'package:magazine_store/app/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/products_page_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {
    i.addLazySingleton<IDioClientService>(DioClientServiceImpl.new);
    i.addLazySingleton<SharedPreferences>(SharedPreferencesService.new);
    i.addLazySingleton<IGetProductsUsecase>(GetProductsUsecaseImpl.new);
    i.addLazySingleton<IProductsRepository>(ProductsRepositoryImpl.new);
    i.addLazySingleton<IProductsDataSource>(ProductsDatasourceImpl.new);
    i.addLazySingleton<ProductsPageController>(ProductsPageController.new);
  }

  @override
  void routes(RouteManager r) {}
}
