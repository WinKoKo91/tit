import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';
import 'package:tit/app/modules/home/views/home_view.dart';
import 'package:tit/app/modules/login/views/login_view.dart';

class AuthService extends GetxService {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const LoginView();
          }
        });
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithApple() async {
    final appleAuth = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final appleProvider = AppleAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }

  signInWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login();
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  signOut() async {
    FirebaseAuth.instance.signOut();

    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
    }

    await _facebookAuth.logOut();

  }
}
