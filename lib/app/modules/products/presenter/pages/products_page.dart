import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magazine_store/app/core/locales/app_locales.dart';
import 'package:magazine_store/app/core/routes/app_routes.dart';
import 'package:magazine_store/app/core/services/snack_bar_service.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/utils/value_objects/currency_vo.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';
import 'package:magazine_store/app/core/widgets/textfield_widget.dart';
import 'package:magazine_store/app/modules/products/domain/entities/products_entity.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/products_page_controller.dart';
import 'package:magazine_store/app/modules/products/presenter/controllers/states/products_page_state.dart';
import 'package:magazine_store/app/modules/products/presenter/widgets/cards_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProductsPage extends StatefulWidget {
  final ProductsPageController productsPageController;

  const ProductsPage({
    super.key,
    required this.productsPageController,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await widget.productsPageController.getProducts();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        listener();
      },
    );
  }

  void listener() {
    final currentState = widget.productsPageController.state;

    if (currentState is ProducPageFailureState) {
      if (mounted) {
        SnackBarService.showError(
          context: context,
          message: currentState.message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget.poppins(
              text: AppLocales.products,
              colorText: AppColors.greyDark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
                onTap: () {
                  widget.productsPageController
                      .getFavoriteProducts()
                      .then((favoriteProducts) {
                    if (favoriteProducts.isNotEmpty) {
                      Modular.to.pushNamed(
                        AppRoutes.favoritesPageRoute,
                        arguments: {
                          'favoriteProducts': favoriteProducts,
                          'productsPageController':
                              widget.productsPageController,
                        },
                      );
                    } else {
                      SnackBarService.showNotice(
                        // ignore: use_build_context_synchronously
                        context: context,
                        message: AppLocales.notice,
                      );
                    }
                  });
                },
                child: SvgPicture.asset('assets/svg/favorite.svg')),
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          final state = widget.productsPageController.state;
          if (state is ProductPageLoadingState) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CardsWidget(
                    id: 0,
                    image: '',
                    title: '',
                    ratingRate: Rating(rate: 0.0, count: 0),
                    ratingCount: Rating(rate: 0.0, count: 0),
                    price: const CurrencyVO(0.0),
                    onTap: null,
                    onTapFavorite: null,
                    isFavorite: false,
                    childFavorite: Container(),
                  );
                },
              ),
            );
          } else if (state is ProductPageSuccessState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 18.0,
                    left: 19.0,
                    right: 19.0,
                  ),
                  child: TextFieldWidget.search(
                    fillColor: AppColors.greyMedium,
                    widthBorder: 0.0,
                    onChanged: (searchQuery) {
                      if (searchQuery.isEmpty) {
                        widget.productsPageController.getProducts();
                      } else {
                        widget.productsPageController.filterProduct(
                          searchQuery,
                          context,
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        widget.productsPageController.listProductsEntity.length,
                    itemBuilder: (context, index) {
                      final products = widget
                          .productsPageController.listProductsEntity[index];
                      final isFavorite =
                          state.favoriteStatus[products.id] ?? false;

                      return CardsWidget(
                        id: products.id,
                        image: products.image,
                        title: products.title,
                        ratingRate: products.rating,
                        ratingCount: products.rating,
                        price: products.price,
                        onTap: () {
                          Modular.to.pushNamed(AppRoutes.productDetailsRoute,
                              arguments: {
                                'id': products.id,
                                'image': products.image,
                                'title': products.title,
                                'rating': products.rating,
                                'price': products.price,
                                'category': products.category,
                                'description': products.description,
                                'isFavorite': isFavorite,
                              });
                        },
                        childFavorite: SvgPicture.asset(
                          isFavorite
                              ? 'assets/svg/favorite_filled.svg'
                              : 'assets/svg/favorite.svg',
                        ),
                        onTapFavorite: () async {
                          await widget.productsPageController
                              .toggleFavoriteProduct(products);
                        },
                        isFavorite: isFavorite,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
