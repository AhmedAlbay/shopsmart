import 'package:shopsmart_user/model/category_model.dart';
import 'package:shopsmart_user/services/assets_manager.dart';

class AppConstant {
  static const String imageUrl = 'https://i.ibb.co/8cNwrbJ/16-Apple-Watch-Series-7.png';

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
      name: 'Accessor',
    ),
    CategoryModel(
      id: AssetsManager.shoes,
      image: AssetsManager.shoes,
      name: 'shoes',
    ),
    CategoryModel(
      id: AssetsManager.pc,
      image: AssetsManager.pc,
      name: 'Laptops',
    ),
    CategoryModel(
      id: AssetsManager.watch,
      image: AssetsManager.watch,
      name: 'Watches',
    ),
    CategoryModel(
      id: AssetsManager.book,
      image: AssetsManager.book,
      name: 'Books',
    ),
  ];
}
