import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tit/app/core/src/app_radius.dart';

import '../../src/app_colors.dart';

BoxDecoration rounderDecoration = BoxDecoration(
    color: Colors.white24,
    borderRadius: BorderRadius.all(Radius.circular(AppRadius.xl.r)));

BoxDecoration dialogBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(AppRadius.x2l.r)),
    );
