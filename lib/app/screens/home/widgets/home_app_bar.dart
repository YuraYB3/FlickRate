import 'package:flutter/material.dart';

import '../../../common/widgets/cached_image.dart';
import '../../../theme/color_palette.dart';

class HomeAppBar extends StatelessWidget {
  final String imgURL;
  final String userName;
  const HomeAppBar({super.key, required this.imgURL, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hi, $userName \u{1F44B}",
            style: const TextStyle(fontSize: 24, color: mainColor),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: CachedImageWidget(
              imageUrl: imgURL,
              height: 50,
              width: 50,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}
