// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/auth/login_screen.dart';
import 'package:shopsmart_user/model/user_model.dart';

import 'package:shopsmart_user/providers/theme_provider.dart';
import 'package:shopsmart_user/providers/user_provider.dart';
import 'package:shopsmart_user/screens/inner_screen/loading_manager.dart';
import 'package:shopsmart_user/screens/inner_screen/viewed_recent.dart';
import 'package:shopsmart_user/screens/inner_screen/wishlist_screen.dart';
import 'package:shopsmart_user/screens/order/order_screen.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/services/my_app_method.dart';

import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/custom_list_title.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  bool isLoading = true;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      return await MyAppMethod.showErrowWariningDialog(
          context: context,
          subTitle: "an error has been occured $error",
          function: () {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    User? user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: LoadingManager(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitleTextWidget(
                      label: 'Please login To Have ultimate Access'),
                ),
              ),
              const SizedBox(height: 10),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
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
                              image: DecorationImage(
                                  image: NetworkImage(
                                    userModel!.userImage,
                                  ),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTextWidget(label: userModel!.userName),
                              SubtitleTextWidget(label: userModel!.userEmail)
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
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTitle(
                            imagePath: AssetsManager.orderSvg,
                            text: 'All Order',
                            function: () async {
                              await Navigator.pushNamed(
                                  context, OrderScreen.routeName);
                            },
                          ),
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTitle(
                            imagePath: AssetsManager.wishlistSvg,
                            text: 'WishList',
                            function: () async {
                              await Navigator.pushNamed(
                                  context, WishListScreen.routeName);
                            },
                          ),
                    CustomListTitle(
                      imagePath: AssetsManager.recent,
                      text: 'Viewed recent',
                      function: () async {
                        await Navigator.pushNamed(
                            context, ViewedRecentScreen.routeName);
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
                  icon: Icon(user == null ? Icons.login : Icons.logout),
                  label: Text(user == null ? "LogIn" : "LogOut"),
                  onPressed: () async {
                    if (user == null) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      await MyAppMethod.showErrowWariningDialog(
                          context: context,
                          subTitle: 'Are You Sure',
                          function: () async {
                            await FirebaseAuth.instance.signOut();

                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          isError: true);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
