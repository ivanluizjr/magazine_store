import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';

class ProductsEntity {
  final int id;
  final String title;
  final CurrencyVO price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductsEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductsEntity.empty() {
    return ProductsEntity(
      id: 0,
      title: '',
      price: const CurrencyVO(0.0),
      description: '',
      category: '',
      image: '',
      rating: Rating(
        rate: 0.0,
        count: 0,
      ),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: (map['rate'] as num).toDouble(),
      count: map['count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
