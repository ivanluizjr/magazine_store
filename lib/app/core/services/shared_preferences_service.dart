import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const favoriteProductsKey = 'favoriteProducts';

  Future<void> addFavoriteProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProducts = prefs.getStringList(favoriteProductsKey) ?? [];
    favoriteProducts.add(productId);
    await prefs.setStringList(favoriteProductsKey, favoriteProducts);
  }

  Future<void> removeFavoriteProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProducts = prefs.getStringList(favoriteProductsKey) ?? [];
    favoriteProducts.remove(productId);
    await prefs.setStringList(favoriteProductsKey, favoriteProducts);
  }

  Future<List<String>> getFavoriteProducts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoriteProductsKey) ?? [];
  }
}
