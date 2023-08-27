import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/color_schemes.dart';
import '../../src/app_colors.dart';

const InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: Color(AppColors.inputBG),
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  labelStyle: TextStyle(fontSize: 14, height: 20 / 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Color(AppColors.primary), width: 1.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

const InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
);
