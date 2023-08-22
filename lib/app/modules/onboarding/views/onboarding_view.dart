import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        indicatorAbove:true,
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
          Container(),
        ],
        totalPage: 3,
        speed: 1.8,
        skipFunctionOverride: controller.onNextPage,
        onFinish: controller.onNextPage,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/chat.svg',
                  height: Get.height * 0.6,
                ),
                const Text('Send Free Message'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/svg/chat.svg',
                  height: Get.height * 0.6,
                ),
                const Text("Connect Your Friend"),

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
                Text('Make Group Chat'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
