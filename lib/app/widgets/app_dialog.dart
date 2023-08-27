import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/src/app_colors.dart';
import '../core/src/app_size.dart';
import '../core/src/app_spacing.dart';
import '../core/theme/decorations/box_decorations.dart';

class AppDialog extends StatelessWidget {
  const AppDialog(
      {Key? key,
      required this.title,
      required this.desc,
      this.buttonText,
      this.onPressed,
      this.type = DialogType.success})
      : super(key: key);

  final String title;
  final String desc;
  final String? buttonText;
  final DialogType type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
            left: AppSpacing.l.w,
            right: AppSpacing.m.w,
            top: AppSpacing.m.h,
            bottom: AppSpacing.x4l.h),
        margin: EdgeInsets.only(top: AppSpacing.x4l.h),
        decoration: dialogBoxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.l.h),
              child: SvgPicture.asset(type == DialogType.success
                  ? "assets/svg/icon_success.svg"
                  : "assets/svg/icon_error.svg"),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: AppSpacing.m.h,
            ),
            Flexible(
              child: Text(
                desc,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: AppSpacing.xl.h,
            ),
            DialogActionWidget(
              onPressed: onPressed,
              type: type,
            )
          ],
        ),
      ),
    );
  }
}

class DialogActionWidget extends StatelessWidget {
  const DialogActionWidget({
    Key? key,
    this.text,
    required this.type,
    this.onPressed,
  }) : super(key: key);

  final String? text;
  final DialogType type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ButtonStyle? style;
    late String defaultText;

    switch (type) {
      case DialogType.success:
        style = ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent, foregroundColor: Colors.white);
        defaultText = "OK";
        break;
      case DialogType.error:
        style = ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent, foregroundColor: Colors.white);
        defaultText = "TRY AGAIN";
        break;
      case DialogType.warning:
        style = ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent, foregroundColor: Colors.white);
        defaultText = "OK";
        break;
      default:
        style = ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent, foregroundColor: Colors.white);
        defaultText = "OK";
    }

    return ElevatedButton(
        style: style,
        onPressed: () {
          Get.back();
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Text(text ?? defaultText, textAlign: TextAlign.center));
  }
}

enum DialogType {
  success,
  fail,
  error,
  warning,
  logout,
}
