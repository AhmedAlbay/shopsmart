import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/theme_provider.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
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
        title: const Text('Ahmed'),
        leading: Image.asset(AssetsManager.shoppingCart),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        image: NetworkImage(''), fit: BoxFit.fill),
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
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
                  function: () {},
                ),
                CustomListTitle(
                  imagePath: AssetsManager.recent,
                  text: 'Viewed recent',
                  function: () {},
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
    );
  }
}
