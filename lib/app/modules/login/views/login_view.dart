import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tit/app/core/src/app_colors.dart';
import 'package:tit/app/core/src/app_spacing.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../widgets/greeting_widget.dart';
import '../../../widgets/social_login_widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: [
          _buildBottomNavigationWidget(),
          if (controller.isLoading)
            Container(
              color: const Color(0x80000000),
            ),
        ],
      ),
      body: Obx(
        () => Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.x3l,
                          right: AppSpacing.x3l,
                          bottom: AppSpacing.x3l,
                        ),
                        child: GreetingWidget(),
                      ),
                      TextFormField(
                        controller: controller.emailTEC,
                        textInputAction: TextInputAction.next,
                        // The validator receives the text that the user has entered.
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        autofillHints: const [AutofillHints.email],
                        enableInteractiveSelection: false,
                        validator: (value) {
                          if (!GetUtils.isEmail(value!)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: controller.passwordTEC,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: InkWell(
                            onTap: controller.onTapHidePassword,
                            child: Icon(controller.isHidePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        obscureText: controller.isHidePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password can\'t be empty';
                          } else if (value.length < 6) {
                            return 'Must be more than 5 characters';
                          }
                          return null;
                        },
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password"))),
                    ],
                  ),
                ),
              ),
            ),
            if (controller.isLoading)
              Container(
                color: const Color(0x80000000),
                alignment: Alignment.center,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(1, 1), // Shadow position
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

  _buildBottomNavigationWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl, vertical: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SocialLoginWidget(
              onAppleLogin: controller.onAppleLogin,
              onFacebookLogin: controller.onFacebookLogin,
              onGoogleLogin: controller.onGoogleLogin,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    onPressed: onLogin, child: const Text("Login"))),
            SizedBox(
              height: AppSpacing.x3l,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Don\'t have an account?  ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Register',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(Routes.REGISTER),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLogin() {
    if (formKey.currentState!.validate()) {
      controller.onEmailAndPasswordLogin();
    }
  }
}

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Divider(),
          Container(
              color: Get.theme.colorScheme.background,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text('Or contiune with')),
        ],
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
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          side: const BorderSide(width: 1, color: Colors.grey),
        ),
        onPressed: onPressed,
        //border width and color

        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        icon: SvgPicture.asset(icon, height: 40, width: 40));
  }
}
