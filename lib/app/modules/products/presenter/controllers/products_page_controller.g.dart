// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsPageController on _ProductsPageControllerBase, Store {
  late final _$listProductsEntityAtom = Atom(
      name: '_ProductsPageControllerBase.listProductsEntity', context: context);

  @override
  List<ProductsEntity> get listProductsEntity {
    _$listProductsEntityAtom.reportRead();
    return super.listProductsEntity;
  }

  @override
  set listProductsEntity(List<ProductsEntity> value) {
    _$listProductsEntityAtom.reportWrite(value, super.listProductsEntity, () {
      super.listProductsEntity = value;
    });
  }

  late final _$productNamesAtom =
      Atom(name: '_ProductsPageControllerBase.productNames', context: context);

  @override
  List<String> get productNames {
    _$productNamesAtom.reportRead();
    return super.productNames;
  }

  @override
  set productNames(List<String> value) {
    _$productNamesAtom.reportWrite(value, super.productNames, () {
      super.productNames = value;
    });
  }

  late final _$singleProductEntityAtom = Atom(
      name: '_ProductsPageControllerBase.singleProductEntity',
      context: context);

  @override
  ProductsEntity get singleProductEntity {
    _$singleProductEntityAtom.reportRead();
    return super.singleProductEntity;
  }

  @override
  set singleProductEntity(ProductsEntity value) {
    _$singleProductEntityAtom.reportWrite(value, super.singleProductEntity, () {
      super.singleProductEntity = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_ProductsPageControllerBase.state', context: context);

  @override
  IProductsPageState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(IProductsPageState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$getProductsAsyncAction =
      AsyncAction('_ProductsPageControllerBase.getProducts', context: context);

  @override
  Future<void> getProducts() {
    return _$getProductsAsyncAction.run(() => super.getProducts());
  }

  late final _$filterProductAsyncAction = AsyncAction(
      '_ProductsPageControllerBase.filterProduct',
      context: context);

  @override
  Future<void> filterProduct(String searchQuery, BuildContext context) {
    return _$filterProductAsyncAction
        .run(() => super.filterProduct(searchQuery, context));
  }

  late final _$toggleFavoriteProductAsyncAction = AsyncAction(
      '_ProductsPageControllerBase.toggleFavoriteProduct',
      context: context);

  @override
  Future<void> toggleFavoriteProduct(ProductsEntity product) {
    return _$toggleFavoriteProductAsyncAction
        .run(() => super.toggleFavoriteProduct(product));
  }

  @override
  String toString() {
    return '''
listProductsEntity: ${listProductsEntity},
productNames: ${productNames},
singleProductEntity: ${singleProductEntity},
state: ${state}
    ''';
  }
}
