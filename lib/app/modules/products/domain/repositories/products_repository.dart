import 'package:magazine_store/app/core/widgets/either.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/failures/products_failure.dart';

abstract class IProductsRepository {
  Future<Either<IProductsFailure, List<ProductsEntity>>> getProducts({
    required List<ProductsEntity> productsEntity,
  });
}
