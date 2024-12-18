import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/presenter/pages/product_details_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ProductDetailsPage(
        id: 1,
        title: "Product 1",
        price: const CurrencyVO(10.0),
        description: "Description 1",
        category: "Category 1",
        image: '',
        isFavorite: false,
        rating: Rating(rate: 4.0, count: 10),
      ),
    );
  }

  testWidgets(
    'displays product details',
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text("Product 1"), findsOneWidget);
      expect(find.text("Description 1"), findsOneWidget);
      expect(find.text("Category 1"), findsOneWidget);
      expect(
        find.text("\$10.0"),
        findsOneWidget,
      );
      expect(
        find.byType(Image),
        findsOneWidget,
      );
    },
  );

  testWidgets('displays rating', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(
      find.text("4.0"),
      findsOneWidget,
    );
  });
}
