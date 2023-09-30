import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/consts/app_constant.dart';

import 'package:shopsmart_user/providers/theme_provider.dart';
import 'package:shopsmart_user/screens/inner_screen/viewed_recent.dart';
import 'package:shopsmart_user/screens/inner_screen/wishlist_screen.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/custom_list_title.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: TitleTextWidget(
                    label: 'Please login To Have ultimate Access'),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        width: 3,
                      ),
                      image: const DecorationImage(
                          image: NetworkImage(AppConstant.imageUrl),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidget(label: 'Ahmed Mohamed'),
                      SubtitleTextWidget(label: 'Ahmed@gmail.com')
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextWidget(label: "General"),
                  CustomListTitle(
                    imagePath: AssetsManager.orderSvg,
                    text: 'All Order',
                    function: () {},
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.wishlistSvg,
                    text: 'WishList',
                    function: () async{
                      await Navigator.pushNamed(context, WishListScreen.routeName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.recent,
                    text: 'Viewed recent',
                    function: () async{
                      await Navigator.pushNamed(context, ViewedRecentScreen.routeName);
                    },
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.address,
                    text: 'Address',
                    function: () {},
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SubtitleTextWidget(
                        label: 'settings',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 30,
                    ),
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark mode"
                        : "Light mode"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  onPressed: () {},
                  icon: const Icon(Icons.login),
                  label: const Text("LogIn")),
            )
          ],
        ),
      ),
    );
  }
}
