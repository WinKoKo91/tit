import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../../../widgets/greeting_widget.dart';
import '../../login/views/login_view.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

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
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        flex: 4,
                        child: GreetingWidget(
                          message: "Let's Chat",
                        ),
                      ),
                      TextFormField(
                        controller: controller.nameTEC,
                        decoration: const InputDecoration(
                          hintText: "User Name",
                        ),
                        obscureText: controller.isHidePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: controller.emailTEC,
                        // The validator receives the text that the user has entered.
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
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
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: controller.confirmPasswordTEC,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                          } else if (value != controller.passwordTEC.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const Spacer(),
                      const SocialLoginWidget(),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                              onPressed: controller.onRegister,
                              child: const Text("Register"))),
                      const Spacer(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Already have an account?  ',
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ],
                        ),
                      ),
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
    ;
  }
}
