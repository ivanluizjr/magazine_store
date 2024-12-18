import 'package:flutter/material.dart';
import 'package:magazine_store/app/core/services/shared_preferences_service.dart';
import 'package:magazine_store/app/core/services/snack_bar_service.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/states/products_page_state.dart';
import 'package:mobx/mobx.dart';

part 'products_page_controller.g.dart';

class ProductsPageController = _ProductsPageControllerBase
    with _$ProductsPageController;

abstract class _ProductsPageControllerBase with Store {
  final IGetProductsUsecase getProductsUsecase;
  final SharedPreferencesService sharedPreferencesService;

  _ProductsPageControllerBase({
    required this.getProductsUsecase,
    required this.sharedPreferencesService,
  });

  @observable
  List<ProductsEntity> listProductsEntity = List<ProductsEntity>.empty();

  @observable
  List<String> productNames = [];

  @observable
  ProductsEntity singleProductEntity = ProductsEntity.empty();

  @observable
  IProductsPageState state = ProductPageInitialState();

  @action
  Future<void> getProducts() async {
    state = ProductPageLoadingState();

    final response = await getProductsUsecase(
      productsEntity: listProductsEntity,
    );

    response.fold(
      onLeft: (error) {
        state = ProducPageFailureState(
          message: error.message,
          stackTrace: error.stackTrace,
        );
      },
      onRight: (success) async {
        listProductsEntity = success;
        productNames = success.map((e) => e.title).toList();
        Map<int, bool> favoriteStatus = {};
        for (var product in listProductsEntity) {
          favoriteStatus[product.id] = await isFavoriteProduct(product);
        }
        state = ProductPageSuccessState(
          listProducts: listProductsEntity,
          favoriteStatus: favoriteStatus,
        );
      },
    );
  }

  @action
  Future<void> filterProduct(
    String searchQuery,
    BuildContext context,
  ) async {
    searchQuery = searchQuery.toLowerCase();

    listProductsEntity = listProductsEntity.where(
      (product) {
        return product.title.toLowerCase().startsWith(searchQuery);
      },
    ).toList();

    if (listProductsEntity.isNotEmpty) {
      singleProductEntity = listProductsEntity[0];
      Map<int, bool> favoriteStatus = {};
      for (var product in listProductsEntity) {
        favoriteStatus[product.id] = await isFavoriteProduct(product);
      }

      state = ProductPageSuccessState(
        listProducts: listProductsEntity,
        favoriteStatus: favoriteStatus,
      );
    } else {
      SnackBarService.showError(
          context: context,
          message: 'Nenhum produto encontrado com o nome $searchQuery');
    }
  }

  @action
  Future<void> toggleFavoriteProduct(ProductsEntity product) async {
    final favoriteProducts =
        await sharedPreferencesService.getFavoriteProducts();
    if (favoriteProducts.contains(
      product.id.toString(),
    )) {
      await sharedPreferencesService.removeFavoriteProduct(
        product.id.toString(),
      );
    } else {
      await sharedPreferencesService.addFavoriteProduct(
        product.id.toString(),
      );
    }
    Map<int, bool> favoriteStatus = {
      ...(state as ProductPageSuccessState).favoriteStatus
    };
    favoriteStatus[product.id] = await isFavoriteProduct(product);
    state = ProductPageSuccessState(
      listProducts: listProductsEntity,
      favoriteStatus: favoriteStatus,
    );
  }

  Future<bool> isFavoriteProduct(ProductsEntity product) async {
    final favoriteProducts =
        await sharedPreferencesService.getFavoriteProducts();
    return favoriteProducts.contains(
      product.id.toString(),
    );
  }

  Future<List<ProductsEntity>> getFavoriteProducts() async {
    List<ProductsEntity> favorites = [];
    for (var product in listProductsEntity) {
      if (await isFavoriteProduct(product)) {
        favorites.add(product);
      }
    }
    return favorites;
  }
}
