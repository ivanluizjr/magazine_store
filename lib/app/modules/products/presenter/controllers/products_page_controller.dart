import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magazine_store/app/core/internet_connection/internet_connection_service.dart';
import 'package:magazine_store/app/core/services/shared_preferences_service.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/states/products_page_state.dart';
import 'package:mobx/mobx.dart';

part 'products_page_controller.g.dart';

// ignore: library_private_types_in_public_api
class ProductsPageController = _ProductsPageControllerBase
    with _$ProductsPageController;

abstract class _ProductsPageControllerBase with Store {
  final IGetProductsUsecase getProductsUsecase;
  final SharedPreferencesService sharedPreferencesService;
  final IInternetConnectionService internetConnectionService;

  _ProductsPageControllerBase({
    required this.getProductsUsecase,
    required this.sharedPreferencesService,
    required this.internetConnectionService,
  }) : _controllerSearch = TextEditingController();

  @observable
  List<ProductsEntity> listProductsEntity = List<ProductsEntity>.empty();

  @observable
  List<String> productNames = [];

  @observable
  ProductsEntity singleProductEntity = ProductsEntity.empty();

  @observable
  IProductsPageState state = ProductPageInitialState();

  @observable
  // ignore: prefer_final_fields
  TextEditingController? _controllerSearch;

  @computed
  TextEditingController? get controllerSearch => _controllerSearch;

  @action
  void clearSearch() {
    _controllerSearch?.clear();
  }

  Timer? _debounce;

  Future<void> getProducts() async {
    state = ProductPageLoadingState();

    try {
      await throwErrorIfNotConnectionWithInternet(internetConnectionService);
    } catch (e) {
      state = ProductPageNoInternetState();
      return;
    }

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
        if (listProductsEntity.isEmpty) {
          state = ProductPageListEmptyState();
        } else {
          productNames = success.map((e) => e.title).toList();
          Map<int, bool> favoriteStatus = {};
          for (var product in listProductsEntity) {
            favoriteStatus[product.id] = await isFavoriteProduct(product);
          }

          state = ProductPageSuccessState(
            listProducts: listProductsEntity,
            favoriteStatus: favoriteStatus,
          );
        }
      },
    );
  }

  @action
  Future<void> filterProduct(
    String searchQuery,
    BuildContext context,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
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
          state = ProductPageEmptyState();
        }
      },
    );
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

  Future<void> throwErrorIfNotConnectionWithInternet(
    IInternetConnectionService service,
  ) async {
    final hasConnection = await service.checkConnection();

    if (!hasConnection) {
      throw const HttpException(
        'No internet connection',
      );
    }
  }
}
