import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:transparent_image/transparent_image.dart';

class CardsWidget extends StatelessWidget {
  final String? image;
  final String title;
  final CurrencyVO price;
  final Rating ratingCount;
  final Rating ratingRate;
  final Function()? onTap;
  final Function()? onTapFavorite;
  final int id;
  final bool isFavorite;
  final Widget? childFavorite;

  const CardsWidget({
    super.key,
    required this.image,
    required this.title,
    required this.ratingCount,
    required this.ratingRate,
    required this.price,
    required this.onTap,
    required this.id,
    required this.onTapFavorite,
    required this.isFavorite,
    required this.childFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                top: 21.0,
                bottom: 22.0,
                right: 26.0,
              ),
              child: Row(
                children: [
                  if (image == null || image!.isEmpty)
                    Image.asset(
                      'assets/images/image_default.png',
                      width: 126.62,
                      height: 121.0,
                    )
                  else
                    Hero(
                      tag: id,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: image!,
                        width: 126.62,
                        height: 121.0,
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget.poppins(
                          text: title,
                          colorText: AppColors.greyDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
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
                                text: '${ratingRate.rate}',
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
                                text: '(${ratingCount.count} reviews)',
                                colorText: AppColors.greyDark.withOpacity(0.65),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GestureDetector(
                                onTap: onTapFavorite,
                                child: childFavorite,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextWidget.poppins(
                            text: '$price',
                            fontSize: 20,
                            colorText: AppColors.price,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: AppColors.divider.withOpacity(0.5),
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
