import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tit/app/core/utils/image_picker_util.dart';
import 'package:tit/app/widgets/image/my_image_widget.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {super.key, this.url = "", this.type = ImageFileType.network});

  final String url;
  final ImageFileType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      height: 90,
      width: 90,
      child: ClipOval(
          child: url.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                  ),
                )
              : MyImageWidget(
                  image: url,
                  type: type,
                )),
    );
  }
}
