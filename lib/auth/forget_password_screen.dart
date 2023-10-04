import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_user/consts/my_validators.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const routename = 'ForgetPasswordScreen';

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> forgetpassFCT() async {
    final isvaild = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvaild) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppNameText(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Image.asset(
                  AssetsManager.forgotPassword,
                  height: size.width * .7,
                  width: size.width * .7,
                ),
                const TitleTextWidget(
                  label: 'Forget Password',
                  fontSize: 24,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SubtitleTextWidget(
                    label:
                        "please enter the email address you'd like your\npassword reset information sent to"),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'email address',
                            prefixIcon: Icon(IconlyLight.message),
                            filled: true),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          forgetpassFCT();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    onPressed: () {},
                    icon: const Icon(
                      IconlyLight.send,
                      size: 23,
                    ),
                    label: const Text(
                      'Request Link',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
