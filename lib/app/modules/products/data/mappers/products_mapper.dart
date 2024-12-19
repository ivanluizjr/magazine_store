import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';

class ProductsMapper {
  static ProductsEntity fromMap(Map<String, dynamic> map) {
    return ProductsEntity(
      id: map['id'],
      title: map['title'],
      price: CurrencyVO(
        (map['price'] as num).toDouble(),
      ),
      description: map['description'],
      category: map['category'],
      image: map['image'],
      rating: Rating.fromMap(
        map['rating'],
      ),
    );
  }
}

Map<String, dynamic> toMap(ProductsEntity productsEntity) {
  return {
    'id': productsEntity.id,
    'title': productsEntity.title,
    'price': productsEntity.price,
    'description': productsEntity.description,
    'category': productsEntity.category,
    'image': productsEntity.image,
    'rating': productsEntity.rating.toMap(),
  };
}
