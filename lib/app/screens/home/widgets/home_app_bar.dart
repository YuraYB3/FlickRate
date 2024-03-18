import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class HomeAppBar extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final String imgURL;
  HomeAppBar({super.key, required this.imgURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hi",
            style: TextStyle(fontSize: 24, color: colorsPalette.mainColor),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imgURL),
            ),
          )
        ],
      ),
    );
  }
}
