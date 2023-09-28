import 'package:shopsmart_user/model/category_model.dart';
import 'package:shopsmart_user/services/assets_manager.dart';

class AppConstant {
  static const String imageUrl =
      'https://images.pexels.com/photos/4158/apple-iphone-smartphone-desk.jpg?auto=compress&cs=tinysrgb&w=600';

  static List<String> imageBanners = [
    AssetsManager.banner1,
    AssetsManager.banner2
  ];
  static List<CategoryModel> categoriesProduct = [
    CategoryModel(
      id: AssetsManager.mobiles,
      image: AssetsManager.mobiles,
      name: 'phones',
    ),
    CategoryModel(
      id: AssetsManager.electronics,
      image: AssetsManager.electronics,
      name: 'electronics',
    ),
    CategoryModel(
      id: AssetsManager.cosmetics,
      image: AssetsManager.cosmetics,
      name: 'cosmetics',
    ),
    CategoryModel(
      id: AssetsManager.fashion,
      image: AssetsManager.fashion,
      name: 'fashion',
    ),
    CategoryModel(
      id: AssetsManager.shoes,
      image: AssetsManager.shoes,
      name: 'shoes',
    ),
    CategoryModel(
      id: AssetsManager.pc,
      image: AssetsManager.pc,
      name: 'Pc',
    ),
    CategoryModel(
      id: AssetsManager.watch,
      image: AssetsManager.watch,
      name: 'Watch',
    ),
    CategoryModel(
      id: AssetsManager.book,
      image: AssetsManager.book,
      name: 'Books',
    ),
  ];
}
