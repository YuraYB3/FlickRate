import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickrate/app/theme/color_palette.dart';

import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final ColorsPalette colorsPalette = ColorsPalette();
  final BoxShape shape;

  CachedImageWidget(
      {super.key,
      required this.imageUrl,
      required this.imageSize,
      required this.shape});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
            shape: shape,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
      placeholder: (context, url) => CircularProgressIndicator(
        color: colorsPalette.mainColor,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
