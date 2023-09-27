import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tit/app/core/utils/image_picker_util.dart';
import 'package:tit/app/widgets/image/my_image_widget.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget(
      {super.key, this.url = "", this.type = ImageFileType.network, this.size = 90});

  final String url;
  final ImageFileType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      height: size,
      width: size,
      child: ClipOval(
          child: url.isEmpty
              ? Padding(
                  padding:  EdgeInsets.all(size *0.1),
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
