import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyTextButton extends StatelessWidget {
  final Function() onButtonPressed;
  final String title;
  final Color textColor;
  final ColorsPalette colorsPalette = ColorsPalette();
  final double textSize;
  MyTextButton(
      {required this.textColor,
      required this.textSize,
      required this.title,
      required this.onButtonPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onButtonPressed,
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: textSize),
        ));
  }
}
