import 'package:magazine_store/app/core/dio_cliient/dio_failure.dart';
import 'package:magazine_store/app/core/widgets/either.dart';
import 'package:magazine_store/app/modules/products/data/datasources/products_datasource.dart';
import 'package:magazine_store/app/modules/products/data/mappers/products_mapper.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/failures/products_failure.dart';
import 'package:magazine_store/app/modules/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  final IProductsDataSource productsDatasource;

  ProductsRepositoryImpl({required this.productsDatasource});

  @override
  Future<Either<IProductsFailure, List<ProductsEntity>>> getProducts({
    required List<ProductsEntity> productsEntity,
  }) async {
    try {
      final productsMap = await productsDatasource.getProducts();

      final result = productsMap
          .map(
            (productMap) => ProductsMapper.fromMap(productMap),
          )
          .toList();

      return Right(result);
    } on DioFailure catch (error, stacTrace) {
      return Left(
        ProductsFailureInternet(
          message: error.message,
          stackTrace: stacTrace,
        ),
      );
    }
  }
}
