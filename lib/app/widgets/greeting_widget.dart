import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({
    super.key,
    this.message
  });

  final String? message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: 'logo',
          child: SvgPicture.asset(
            'assets/svg/logo.svg',
            height: 120,
            width: 120,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          message?? 'Welcome back your\'ve been missed!',
          style: Get.theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}