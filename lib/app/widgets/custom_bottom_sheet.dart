import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomModalBottomSheet {
  static void showBottomSheet(
    context,
    Widget titleWidget,
    Widget contentWidget, {
    bool willShowFullScreen = false,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.zero,
          topLeft: Radius.circular(16),
          bottomRight: Radius.zero,
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4,left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: titleWidget),
                    IconButton(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      onPressed:
                    Get.back, icon:const Icon(
                      Icons.close_sharp,
                      color: Colors.black,
                      size: 24,

                    ),)

                  ],
                ),
              ),
              willShowFullScreen
                  ? Expanded(child: contentWidget)
                  : contentWidget
            ],
          ),
        );
      },
    );
  }
}
