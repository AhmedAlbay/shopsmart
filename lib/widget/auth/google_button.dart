import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopsmart_user/root_screen.dart';
import 'package:shopsmart_user/services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void> _googleSiginIn({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacementNamed(context, RootScreen.routeName);
          });
        } on FirebaseException catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await MyAppMethod.showErrowWariningDialog(
                context: context,
                subTitle: "an error has been occured ${error.message}",
                fontsize: 16,
                function: () {});
          });
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await MyAppMethod.showErrowWariningDialog(
                context: context,
                subTitle: "an error has been occured $error",
                function: () {});
          });
        }
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      Navigator.pushReplacementNamed(context, RootScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(fontSize: 22, color: Colors.black),
      ),
      onPressed: () {
        _googleSiginIn(context: context);
      },
    );
  }
}
