import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tit_ti_too/app/routes/app_pages.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.black,
        ),
        skipTextButton: Text('Skip'),
        trailing: Text('Login'),
        background: [
          Container(),
          Container(),
        ],
        totalPage: 2,
        speed: 1.8,
        skipFunctionOverride: () {
          Get.offNamed(Routes.HOME);
        },
        onFinish: () {
          Get.offNamed(Routes.HOME);
        },
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/chat.svg',
                  height: Get.height * 0.6,
                ),
                Text('Send Free Message'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/message.svg',
                  height: Get.height * 0.6,
                ),
                Text('Send Free Message'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
