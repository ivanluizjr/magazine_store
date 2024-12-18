import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_store/app/core/dio_cliient/dio/dio_client_service_impl.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_failure.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_response.dart';
import 'package:magazine_store/app/core/locales/api/products_locales_api.dart';
import 'package:magazine_store/app/modules/products/data/datasources/impl/products_datasource_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockDioClientServiceImpl extends Mock implements DioClientServiceImpl {}

void main() {
  late ProductsDatasourceImpl productsDatasource;
  late DioClientServiceImpl dioService;

  setUp(() {
    dioService = MockDioClientServiceImpl();
    productsDatasource = ProductsDatasourceImpl(dioService: dioService);
  });

  group('getProducts', () {
    test('retorna lista de produtos quando a chamada é bem sucedida', () async {
      // Arrange
      final products = [
        {
          "id": 1,
          "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
          "price": 109.95,
          "description":
              "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
          "category": "men's clothing",
          "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
          "rating": {"rate": 3.9, "count": 120}
        },
      ];
      final dioResponse = DioResponse(products, statusCode: 200);
      when(() => dioService.get(ProductsLocalesApi.productsEndPoint))
          .thenAnswer((_) async => dioResponse);

      // Act
      final result = await productsDatasource.getProducts();

      // Assert
      expect(result, products);
      verify(() => dioService.get(ProductsLocalesApi.productsEndPoint))
          .called(1);
    });

    test('lança uma exceção quando a chamada falha', () async {
      // Arrange
      const dioFailure = DioFailure(statusCode: 500);
      when(() => dioService.get(ProductsLocalesApi.productsEndPoint))
          .thenThrow(dioFailure);

      // Act
      expect(() async => await productsDatasource.getProducts(),
          throwsA(dioFailure));

      // Assert
      verify(() => dioService.get(ProductsLocalesApi.productsEndPoint))
          .called(1);
    });
  });
}
