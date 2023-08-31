import 'package:flutter/material.dart';

import '../modules/login/views/login_view.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget(
      {super.key,
        required this.onAppleLogin,
        required this.onFacebookLogin,
        required this.onGoogleLogin});

  final VoidCallback onFacebookLogin;
  final VoidCallback onGoogleLogin;
  final VoidCallback onAppleLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppIconButtonWidget(
          onPressed: onFacebookLogin,
          icon: 'assets/svg/logo_facebook.svg',
        ),
        AppIconButtonWidget(
          onPressed: onGoogleLogin,
          icon: 'assets/svg/logo_google.svg',
        ),
        AppIconButtonWidget(
          onPressed: onAppleLogin,
          icon: 'assets/svg/logo_apple.svg',
        ),
      ],
    );
  }
}