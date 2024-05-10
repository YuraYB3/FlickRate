import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickrate/app/common/screens/my_loading_widget.dart';

import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxShape shape;

  const CachedImageWidget(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.shape,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: MyLoadingScreen(),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
