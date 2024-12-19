import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/products_page_controller.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/states/products_page_state.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/favorites_page.dart';
import 'package:magazine_store/app/modules/products/presenter/widgets/cards_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsPageController extends Mock
    implements ProductsPageController {}

void main() {
  late MockProductsPageController mockProductsPageController;

  setUp(
    () {
      mockProductsPageController = MockProductsPageController();
    },
  );

  Widget createWidgetUnderTest(List<ProductsEntity> favoriteProducts) {
    return MaterialApp(
      home: FavoritesPage(
        favoriteProducts: favoriteProducts,
        productsPageController: mockProductsPageController,
      ),
    );
  }

  testWidgets(
    'displays empty state when no favorite products',
    (WidgetTester tester) async {
      when(() => mockProductsPageController.state).thenReturn(
        ProductPageSuccessState(
          listProducts: [],
          favoriteStatus: {},
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest([]));

      await tester.pump();

      expect(find.text("No favorite products"), findsOneWidget);
    },
  );

  testWidgets(
    'displays favorite products',
    (WidgetTester tester) async {
      final favoriteProducts = [
        ProductsEntity(
          id: 1,
          title: "Product 1",
          price: const CurrencyVO(10.0),
          description: "Description 1",
          category: "Category 1",
          image: "assets/images/image_default.png",
          rating: Rating(rate: 4.0, count: 10),
        ),
      ];

      when(() => mockProductsPageController.state).thenReturn(
        ProductPageSuccessState(
          listProducts: favoriteProducts,
          favoriteStatus: {1: true},
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest(favoriteProducts));

      // Pump again to allow the ValueListenableBuilder to update
      await tester.pump();

      // Verifique se o CardsWidget está presente
      expect(find.byType(CardsWidget), findsOneWidget);

      // Verifique se os textos dentro do CardsWidget estão presentes
      expect(find.text("Product 1"), findsOneWidget);
      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.text("Category 1"), findsOneWidget);
      expect(find.text("\$10.0"),
          findsOneWidget); // Assuming CurrencyVO displays as $10.0
    },
  );
}
