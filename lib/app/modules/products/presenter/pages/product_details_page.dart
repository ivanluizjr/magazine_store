import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magazine_store/app/core/locales/app_locales.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/presenter/widgets/product_details_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;
  final String title;
  final CurrencyVO price;
  final String description;
  final String category;
  final String image;
  final bool isFavorite;
  final Rating rating;

  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.rating,
    required this.isFavorite,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget.poppins(
              text: AppLocales.productDetails,
              colorText: AppColors.greyDark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SvgPicture.asset(
              widget.isFavorite
                  ? 'assets/svg/favorite_filled.svg'
                  : 'assets/svg/favorite.svg',
            ),
          ],
        ),
      ),
      body: ProductDetailsWidget(
        id: widget.id,
        image: widget.image,
        title: widget.title,
        ratingRate: widget.rating.rate,
        ratingCount: widget.rating.count,
        price: widget.price,
        category: widget.category,
        description: widget.description,
      ),
    );
  }
}
