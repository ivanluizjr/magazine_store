abstract class IProductsFailure implements Exception {
  abstract final String message;
  abstract final StackTrace? stackTrace;
}

class ProductsFailure implements IProductsFailure {
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  ProductsFailure({
    required this.message,
    this.stackTrace,
  });
}

class ProductsFailureInternet implements IProductsFailure {
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  ProductsFailureInternet({
    required this.message,
    this.stackTrace,
  });
}
