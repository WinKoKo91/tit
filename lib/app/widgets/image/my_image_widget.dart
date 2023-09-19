import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class MyImageWidget extends StatelessWidget {
  MyImageWidget({
    Key? key,
    required this.image,
    this.errorImage = "assets/svg/logo.svg",
    this.placeholderImage = "assets/svg/logo.svg",
    this.type = ImageFileType.assets,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.color,
  }) : super(key: key);

  String image;
  String errorImage;
  String placeholderImage;
  ImageFileType type;
  BoxFit fit;
  double? height;
  double? width;
  Color? color;

  @override
  Widget build(BuildContext context) {
    //TODO: add catch image widget
    switch (type) {
      case ImageFileType.network:
        return CachedNetworkImage(
          fit: fit,
          height: height,
          width: width,
          placeholder: (context, url) => Padding(
            padding: const EdgeInsets.all(8),
            child: (placeholderImage.isEmpty)
                ? const Center(
                    child: SpinKitCircle(   color: Colors.white,
                      size: 32.0,),
                  )
                : SvgPicture.asset(
                    placeholderImage,
                    height: height,
                    width: width,
                    fit: fit,
                  ),
          ),
          errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.all(8),
            child: (errorImage.isEmpty)
                ? const Center(
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 32.0,
                    ),
                  )
                : SvgPicture.asset(
                    errorImage,
                    height: height,
                    width: width,
                    fit: fit,
                  ),
          ),
          imageUrl: image,
        );

      case ImageFileType.assets:
        return Image.asset(
          image,
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              errorImage,
              height: height,
              width: width,
              fit: fit,
            ),
          ),
        );
      case ImageFileType.file:
        return Image.file(
          File(
            image,
          ),
          height: height,
          width: width,
          fit: fit,
        );
      case ImageFileType.svg:
        return SvgPicture.asset(
          image,
          height: height,
          width: width,
          fit: fit,
          color: color,
        );
    }
  }
}

enum ImageFileType {
  network,
  file,
  assets,
  svg,
}
