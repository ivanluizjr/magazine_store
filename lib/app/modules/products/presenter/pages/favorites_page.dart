import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magazine_store/app/core/locales/app_locales.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/products_page_controller.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/states/products_page_state.dart';
import 'package:magazine_store/app/modules/products/presenter/widgets/cards_widget.dart';

class FavoritesPage extends StatefulWidget {
  final List<ProductsEntity> favoriteProducts;
  final ProductsPageController productsPageController;

  const FavoritesPage({
    super.key,
    required this.favoriteProducts,
    required this.productsPageController,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
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
              text: AppLocales.favorites,
              colorText: AppColors.greyDark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          final state = widget.productsPageController.state;
          if (state is ProductPageSuccessState) {
            if (widget.favoriteProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/list_empty.svg'),
                    TextWidget.poppins(
                      text: 'No favorite products',
                      fontSize: 18,
                      colorText: Colors.grey,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: widget.favoriteProducts.length,
                itemBuilder: (context, index) {
                  final products = widget.favoriteProducts[index];
                  final isFavorite = state.favoriteStatus[products.id] ?? false;
                  return CardsWidget(
                    id: products.id,
                    image: products.image,
                    title: products.title,
                    ratingRate: products.rating,
                    ratingCount: products.rating,
                    price: products.price,
                    onTap: () {},
                    childFavorite: Container(),
                    onTapFavorite: () async {
                      await widget.productsPageController
                          .toggleFavoriteProduct(products);
                    },
                    isFavorite: isFavorite,
                  );
                },
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
