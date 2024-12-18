import 'package:magazine_store/app/core/widgets/either.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/failures/products_failure.dart';
import 'package:magazine_store/app/modules/products/domain/repositories/products_repository.dart';

abstract class IGetProductsUsecase {
  Future<Either<IProductsFailure, List<ProductsEntity>>> call(
      {required List<ProductsEntity> productsEntity});
}

class GetProductsUsecaseImpl implements IGetProductsUsecase {
  final IProductsRepository productsRepositoy;

  GetProductsUsecaseImpl({required this.productsRepositoy});

  @override
  Future<Either<IProductsFailure, List<ProductsEntity>>> call(
      {required List<ProductsEntity> productsEntity}) async {
    final response = await productsRepositoy.getProducts(
      productsEntity: productsEntity,
    );

    return response;
  }
}
