import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_failure.dart';
import 'package:magazine_store/app/core/widgets/either.dart';
import 'package:magazine_store/app/modules/products/data/datasources/products_datasource.dart';
import 'package:magazine_store/app/modules/products/data/repositories/products_repository_impl.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/failures/products_failure.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsDatasource extends Mock implements IProductsDataSource {}

void main() {
  late ProductsRepositoryImpl productsRepository;
  late IProductsDataSource productsDatasource;

  setUp(() {
    productsDatasource = MockProductsDatasource();
    productsRepository =
        ProductsRepositoryImpl(productsDatasource: productsDatasource);
  });

  group('ProductsRepository', () {
    final productsMap = [
      {
        "id": 1,
        "title": "Product 1",
        "price": 10.0,
        "description": "Description 1",
        "category": "Category 1",
        "image": "Image 1",
        "rating": {
          "rate": 4.0,
          "count": 10,
        },
      },
      {
        "id": 2,
        "title": "Product 2",
        "price": 20.0,
        "description": "Description 2",
        "category": "Category 2",
        "image": "Image 2",
        "rating": {
          "rate": 4.5,
          "count": 20,
        },
      },
    ];

    test('retorna lista de produtos quando a chamada é bem sucedida', () async {
      // Arrange
      when(() => productsDatasource.getProducts())
          .thenAnswer((_) async => productsMap);

      // Act
      final result = await productsRepository.getProducts(
          productsEntity: List<ProductsEntity>.empty());

      // Assert
      expect(result, isA<Right<IProductsFailure, List<ProductsEntity>>>());
      verify(() => productsDatasource.getProducts()).called(1);
    });

    test('retorna falha quando a chamada falha', () async {
      // Arrange
      when(() => productsDatasource.getProducts()).thenThrow(
        const DioFailure(
          statusCode: 400,
        ),
      );

      // Act
      final result = await productsRepository.getProducts(
          productsEntity: List<ProductsEntity>.empty());

      // Assert
      expect(result, isA<Left<IProductsFailure, List<ProductsEntity>>>());
      verify(() => productsDatasource.getProducts()).called(1);
    });
  });
}
