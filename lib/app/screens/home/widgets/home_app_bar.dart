import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  HomeAppBar({
    super.key,
  });

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
              backgroundColor: colorsPalette.mainColor,
            ),
          )
        ],
      ),
    );
  }
}
