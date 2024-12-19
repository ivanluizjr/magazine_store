import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/products_page_controller.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/states/products_page_state.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/products_page.dart';
import 'package:magazine_store/app/modules/products/presenter/widgets/cards_widget.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';

class MockProductsPageController extends Mock
    implements ProductsPageController {}

void main() {
  late MockProductsPageController mockProductsPageController;

  setUp(
    () {
      mockProductsPageController = MockProductsPageController();
      when(() => mockProductsPageController.getProducts()).thenAnswer(
        (_) async {},
      );
    },
  );

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ProductsPage(productsPageController: mockProductsPageController),
    );
  }

  testWidgets(
    'displays loading state',
    (WidgetTester tester) async {
      when(() => mockProductsPageController.state).thenReturn(
        ProductPageLoadingState(),
      );

      await tester.pumpWidget(
        createWidgetUnderTest(),
      );

      expect(find.byType(Shimmer), findsOneWidget);
    },
  );

  testWidgets(
    'displays success state',
    (WidgetTester tester) async {
      final products = [
        ProductsEntity(
          id: 1,
          title: "Product 1",
          price: const CurrencyVO(10.0),
          description: "Description 1",
          category: "Category 1",
          image: '',
          rating: Rating(
            rate: 4.0,
            count: 10,
          ),
        ),
      ];

      when(() => mockProductsPageController.state).thenReturn(
        ProductPageSuccessState(
          listProducts: products,
          favoriteStatus: {},
        ),
      );
      when(() => mockProductsPageController.listProductsEntity)
          .thenReturn(products);

      await tester.pumpWidget(
        createWidgetUnderTest(),
      );

      expect(find.byType(CardsWidget), findsOneWidget);
    },
  );

  testWidgets(
    'displays failure state',
    (WidgetTester tester) async {
      when(() => mockProductsPageController.state).thenReturn(
        ProducPageFailureState(message: 'Error'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: ScaffoldMessenger(
            child: Scaffold(
              body: ProductsPage(
                productsPageController: mockProductsPageController,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    },
  );
}
