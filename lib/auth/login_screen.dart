import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_user/auth/register_screen.dart';
import 'package:shopsmart_user/consts/my_validators.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/auth/google_button.dart';
import 'package:shopsmart_user/widget/subtitle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
    static const routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFoucs;
  late final FocusNode _passwordFoucs;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFoucs = FocusNode();
    _passwordFoucs = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFoucs.dispose();
    _passwordFoucs.dispose();
    super.dispose();
  }

  Future<void> _loginFCT() async {
    // ignore: unused_local_variable
    final isVaild = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaild) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Center(
                  child: AppNameText(
                    fontsize: 32,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SubtitleTextWidget(
                    label: 'WelcomeBack ',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SubtitleTextWidget(
                    label:
                        'Lest\'s get  you Logged in so you can start exploring',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFoucs,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email Address",
                          prefixIcon: Icon(IconlyLight.message),
                        ),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_passwordFoucs);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFoucs,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "********",
                          prefixIcon: const Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          _loginFCT();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const SubtitleTextWidget(
                      label: "Forget Password ?",
                      textDecoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () {
                      _loginFCT();
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SubtitleTextWidget(
                  label: "or connect using".toUpperCase(),
                  fontSize: 22,
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: SizedBox(
                              height: kBottomNavigationBarHeight,
                              child: FittedBox(child: GoogleButton())),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              child: const Text(
                                "Guest",
                                style: TextStyle(fontSize: 22),
                              ),
                              onPressed: () {
                                _loginFCT();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SubtitleTextWidget(label: ' Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: const SubtitleTextWidget(
                        label: "Sign up",
                        textDecoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
