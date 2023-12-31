// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopsmart_user/root_screen.dart';
import 'package:shopsmart_user/services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void> _googleSignIn({required BuildContext context}) async {
  final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

  if (googleAccount != null) {
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      try {
        final authResult = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );

        if (authResult.additionalUserInfo != null && authResult.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance.collection("users").doc(authResult.user!.uid).set({
            "userId": authResult.user!.uid,
            "userName": authResult.user!.displayName,
            "userEmail": authResult.user!.email,
            "userImage": authResult.user!.photoURL,
            "createdAt": FieldValue.serverTimestamp(),
            "userCart": [],
            'userWish': [],
          });
        }

        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseException catch (error) {
        // Handle Firebase exceptions, such as authentication errors.
      
        await MyAppMethod.showErrowWariningDialog(
          context: context,
          subTitle: "An error has occurred: ${error.message}", function: (){},
        );
      } catch (error) {
        // Handle other exceptions.
       
        await MyAppMethod.showErrowWariningDialog(
          context: context,
          subTitle: "An error has occurred: $error",function: (){},
        );
      }
    }
  }

  // If Google Sign-In didn't occur or any other errors happened, this will be executed.
  Navigator.pushReplacementNamed(context, RootScreen.routeName);
}

  // Future<void> _googleSiginIn({required BuildContext context}) async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final googleAuth = await googleAccount.authentication;
  //     if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //       try {
  //         final authResult = await FirebaseAuth.instance
  //             .signInWithCredential(GoogleAuthProvider.credential(
  //           idToken: googleAuth.idToken,
  //           accessToken: googleAuth.accessToken,
  //         ));
  //         if (authResult.additionalUserInfo!.isNewUser) {
  //           await FirebaseFirestore.instance
  //               .collection("users")
  //               .doc(authResult.user!.uid)
  //               .set({
  //             "userId": authResult.user!.uid,
  //             "userName": authResult.user!.displayName,
  //             "userEmail": authResult.user!.email,
  //             "userImage": authResult.user!.photoURL,
  //             "createdAt": Timestamp.now(),
  //             "userCart": [],
  //             'userWish': [],
  //           });
  //         }
  //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //           Navigator.pushReplacementNamed(context, RootScreen.routeName);
  //         });
  //       } on FirebaseException catch (error) {
  //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //           await MyAppMethod.showErrowWariningDialog(
  //               context: context,
  //               subTitle: "an error has been occured ${error.message}",
  //               fontsize: 16,
  //               function: () {});
  //         });
  //       } catch (error) {
  //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //           await MyAppMethod.showErrowWariningDialog(
  //               context: context,
  //               subTitle: "an error has been occured $error",
  //               function: () {});
  //         });
  //       }
  //     }
  //   }
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     Navigator.pushReplacementNamed(context, RootScreen.routeName);
  //   });
  // }

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
        _googleSignIn(context: context);
      },
    );
  }
}
