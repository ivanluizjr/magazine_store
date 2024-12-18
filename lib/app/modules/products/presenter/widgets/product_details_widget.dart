import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';

class ProductDetailsWidget extends StatelessWidget {
  final int id;
  final String image;
  final String title;
  final double ratingRate;
  final int ratingCount;
  final CurrencyVO price;
  final String category;
  final String description;

  const ProductDetailsWidget({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.ratingRate,
    required this.ratingCount,
    required this.price,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 23.0),
              child: Hero(
                tag: id,
                child: image.isNotEmpty
                    ? Image.network(
                        image,
                        height: 309.66,
                        width: 323.93,
                      )
                    : Image.asset('assets/images/image_default.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.8,
                left: 18.0,
              ),
              child: TextWidget.poppins(
                text: title,
                fontSize: 20,
                colorText: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                top: 22.0,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SvgPicture.asset(
                      'assets/svg/star.svg',
                      height: 19.0,
                      width: 22.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 8.0,
                    ),
                    child: TextWidget.poppins(
                      text: '$ratingRate',
                      colorText: AppColors.greyDark.withOpacity(0.65),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 5.0,
                    ),
                    child: TextWidget.poppins(
                      text: '($ratingCount reviews)',
                      colorText: AppColors.greyDark.withOpacity(0.65),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: TextWidget.poppins(
                      text: '\$${price.value.toStringAsFixed(1)}',
                      colorText: AppColors.priceColorDetails,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                left: 18.0,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.sort,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextWidget.poppins(
                      text: category,
                      fontSize: 16,
                      colorText: AppColors.descriptionColorDetails,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 44.0,
                left: 18.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.menu,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextWidget.poppins(
                        text: description,
                        fontSize: 16,
                        colorText: AppColors.descriptionColorDetails,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
