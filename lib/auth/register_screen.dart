// ignore_for_file: use_build_context_synchronously, avoid_single_cascade_in_expression_statements, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_user/consts/my_validators.dart';
import 'package:shopsmart_user/root_screen.dart';
import 'package:shopsmart_user/screens/inner_screen/loading_manager.dart';
import 'package:shopsmart_user/services/my_app_method.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/auth/picker_image_widget.dart';
import 'package:shopsmart_user/widget/subtitle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = 'RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _emailController,
      _nameController,
      _passwordController,
      _confirmpasswordController;

  late final FocusNode _emailFoucs,
      _passwordFoucs,
      _nameFoucs,
      _confirmpasswordFoucs;

  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  XFile? _pickerImage;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _confirmpasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFoucs = FocusNode();
    _passwordFoucs = FocusNode();
    _nameFoucs = FocusNode();
    _confirmpasswordFoucs = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _confirmpasswordController.dispose();
    _passwordController.dispose();
    _emailFoucs.dispose();
    _nameFoucs.dispose();
    _confirmpasswordFoucs.dispose();
    _passwordFoucs.dispose();
    super.dispose();
  }

  Future<void> _registerFCT() async {
    // ignore: unused_local_variable
    final isVaild = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaild) {
      _formKey.currentState!.save();
    }
    // if (_pickerImage == null) {
    //   return MyAppMethod.showErrowWariningDialog(
    //       context: context,
    //       subTitle: "Make sure to pick Image",
    //       function: () {});
    // }
    try {
      setState(() {
        isLoading = true;
      });
      await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      User? user = auth.currentUser;
      final uid = user!.uid;
      await FirebaseFirestore.instance.collection('users')
        ..doc(uid).set({
          "userId": uid,
          "userName": _nameController.text,
          "userEmail": _emailController.text.toLowerCase(),
          "userImage": '',
          "createdAt": Timestamp.now(),
          "userCart": [],
          "userWish": [],
        });
      Fluttertoast.showToast(
          msg: "An account has been created",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RootScreen.routeName);
    } on FirebaseException catch (error) {
      return await MyAppMethod.showErrowWariningDialog(
          context: context,
          subTitle: "an error has been occured ${error.message}",
          fontsize: 16,
          function: () {});
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

  Future<void> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    MyAppMethod.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickerImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      imageFCT: () async {
        _pickerImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickerImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isLoading,
          child: Padding(
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
                          'Sign up now to receive special offers and update\nfrom you app',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: size.width * 0.3,
                      width: size.width * 0.3,
                      child: PickerImageWidget(
                          pickerImage: _pickerImage,
                          function: () async {
                            await imagePicker();
                          })),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFoucs,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Full name",
                            prefixIcon: Icon(IconlyLight.profile),
                          ),
                          validator: (value) {
                            return MyValidators.displayNamevalidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_emailFoucs);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                          textInputAction: TextInputAction.next,
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
                            FocusScope.of(context)
                                .requestFocus(_confirmpasswordFoucs);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _confirmpasswordController,
                          focusNode: _confirmpasswordFoucs,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Repet Password",
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
                            return MyValidators.repeatPasswordValidator(
                                value: value,
                                password: _passwordController.text);
                          },
                          onFieldSubmitted: (value) {
                            _registerFCT();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      icon: const Icon(IconlyLight.addUser),
                      label: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 22),
                      ),
                      onPressed: () {
                        _registerFCT();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
