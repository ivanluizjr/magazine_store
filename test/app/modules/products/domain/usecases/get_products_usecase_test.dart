import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/core/widgets/either.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/domain/failures/products_failure.dart';
import 'package:magazine_store/app/modules/products/domain/repositories/products_repository.dart';
import 'package:magazine_store/app/modules/products/domain/usecases/get_products_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockIProductsRepository extends Mock implements IProductsRepository {}

void main() {
  late GetProductsUsecaseImpl getProductsUsecase;
  late IProductsRepository productsRepository;

  setUp(() {
    productsRepository = MockIProductsRepository();
    getProductsUsecase =
        GetProductsUsecaseImpl(productsRepositoy: productsRepository);
  });

  group('GetProductsUsecase', () {
    List<ProductsEntity> productsEntity = List<ProductsEntity>.empty();
    test('retorna lista de produtos quando a chamada é bem sucedida', () async {
      // Arrange
      final products = [
        ProductsEntity(
            id: 1,
            title: "Product 1",
            price: const CurrencyVO(10.0),
            description: "Description 1",
            category: "Category 1",
            image: "Image 1",
            rating: Rating(rate: 4.0, count: 10)),
        ProductsEntity(
            id: 2,
            title: "Product 2",
            price: const CurrencyVO(20.0),
            description: "Description 2",
            category: "Category 2",
            image: "Image 2",
            rating: Rating(rate: 4.5, count: 20)),
      ];

      when(() => productsRepository.getProducts(productsEntity: productsEntity))
          .thenAnswer((_) async => Right(products));

      // Act
      final result = await getProductsUsecase(productsEntity: productsEntity);

      // Assert
      expect(result, isA<Right<IProductsFailure, List<ProductsEntity>>>());
      verify(() =>
              productsRepository.getProducts(productsEntity: productsEntity))
          .called(1);
    });

    test('retorna falha quando a chamada falha', () async {
      // Arrange
      final failure = ProductsFailure(message: 'Erro ao retornar chamada');
      when(() => productsRepository.getProducts(productsEntity: productsEntity))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await getProductsUsecase(productsEntity: productsEntity);

      // Assert
      expect(result, isA<Left<IProductsFailure, List<ProductsEntity>>>());
      verify(() =>
              productsRepository.getProducts(productsEntity: productsEntity))
          .called(1);
    });
  });
}
