// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../domain/entities/products_entity.dart';

abstract class IProductsPageState {
  final Map<int, bool> favoriteStatus;

  IProductsPageState(this.favoriteStatus);
}

class ProductPageInitialState implements IProductsPageState {
  @override
  Map<int, bool> get favoriteStatus => throw UnimplementedError();
}

class ProductPageLoadingState implements IProductsPageState {
  @override
  Map<int, bool> get favoriteStatus => throw UnimplementedError();
}

class ProductPageSuccessState implements IProductsPageState {
  final List<ProductsEntity> listProducts;
  @override
  final Map<int, bool> favoriteStatus;

  ProductPageSuccessState({
    required this.listProducts,
    required this.favoriteStatus,
  });
}

class ProducPageFailureState implements IProductsPageState {
  final String message;
  final StackTrace? stackTrace;

  ProducPageFailureState({
    required this.message,
    this.stackTrace,
  });

  @override
  Map<int, bool> get favoriteStatus => throw UnimplementedError();
}
