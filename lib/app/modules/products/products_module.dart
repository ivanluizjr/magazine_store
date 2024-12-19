import 'package:flutter_modular/flutter_modular.dart';
import 'package:magazine_store/app/core/dio_cliient/dio/dio_client_service_impl.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_client_service.dart';
import 'package:magazine_store/app/core/internet_connection/internet_connection_service.dart';
import 'package:magazine_store/app/core/internet_connection/internet_connection_service_impl.dart';
import 'package:magazine_store/app/core/routes/app_routes.dart';
import 'package:magazine_store/app/core/services/shared_preferences_service.dart';
import 'package:magazine_store/app/modules/products/data/datasources/impl/products_datasource_impl.dart';
import 'package:magazine_store/app/modules/products/data/datasources/products_datasource.dart';
import 'package:magazine_store/app/modules/products/data/repositories/products_repository_impl.dart';
import 'package:magazine_store/app/modules/products/domain/repositories/products_repository.dart';
import 'package:magazine_store/app/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/products_page_controller.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/favorites_page.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/no_internet_page.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/product_details_page.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/products_page.dart';
import 'package:magazine_store/app_module.dart';

class ProductsModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<SharedPreferencesService>(SharedPreferencesService.new);
    i.addLazySingleton<IInternetConnectionService>(
        InternetConnecionServiceImpl.new);
    i.addLazySingleton<IGetProductsUsecase>(GetProductsUsecaseImpl.new);
    i.addLazySingleton<IProductsRepository>(ProductsRepositoryImpl.new);
    i.addLazySingleton<IProductsDataSource>(ProductsDatasourceImpl.new);
    i.addLazySingleton<IDioClientService>(DioClientServiceImpl.new);
    i.addLazySingleton<ProductsPageController>(ProductsPageController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      AppRoutes.initialRoute,
      child: (context) => ProductsPage(
        productsPageController: Modular.get(),
      ),
    );
    r.child(
      AppRoutes.productDetailsRoute,
      child: (context) => ProductDetailsPage(
        id: r.args.data['id'],
        image: r.args.data['image'],
        category: r.args.data['category'],
        description: r.args.data['description'],
        price: r.args.data['price'],
        rating: r.args.data['rating'],
        title: r.args.data['title'],
        isFavorite: r.args.data['isFavorite'],
      ),
    );
    r.child(
      AppRoutes.favoritesPageRoute,
      child: (context) => FavoritesPage(
        favoriteProducts: r.args.data['favoriteProducts'],
        productsPageController: r.args.data['productsPageController'],
      ),
    );
    r.child(
      AppRoutes.noInternetPageRoute,
      child: (context) => const NoInternetPage(),
    );
  }
}
