import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Hero(
                        tag: 'logo',
                        child: SvgPicture.asset(
                          'assets/svg/logo.svg',
                          height: 120,
                          width: 120,
                        ),
                      ),
                      const Text('Welcome back your\'ve been missed!'),
                      const Spacer(),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: "Username",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password"))),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text("Login"))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 36.0, horizontal: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(),
                            Container(
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: const Text('Or contiune with')),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Platform.isAndroid
                              ? AppIconButtonWidget(
                                  onPressed: controller.onGoogleLogin,
                                  icon: 'assets/svg/logo_google.svg',
                                )
                              : AppIconButtonWidget(
                                  onPressed: controller.onAppleLogin,
                                  icon: 'assets/svg/logo_apple.svg',
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          AppIconButtonWidget(
                            onPressed: controller.onFacebookLogin,
                            icon: 'assets/svg/logo_facebook.svg',
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (controller.isLogin)
              Container(
                color: Color(0x80000000),
                alignment: Alignment.center,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ]),
                  padding: const EdgeInsets.all(16),
                  child: const SpinKitCircle(
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppIconButtonWidget extends StatelessWidget {
  const AppIconButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.all(16),
        style: IconButton.styleFrom(backgroundColor: Color(0xfff3f3f3)),
        onPressed: onPressed,
        icon: SvgPicture.asset(icon, height: 48, width: 48));
  }
}
