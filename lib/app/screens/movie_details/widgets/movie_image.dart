import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class MovieImage extends StatelessWidget {
  const MovieImage(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.imgUrl});

  final double screenHeight;
  final double screenWidth;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return CachedImageWidget(
        imageUrl: imgUrl, imageSize: screenWidth, shape: BoxShape.rectangle);
  }
}
