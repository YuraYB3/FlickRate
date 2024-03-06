import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class DrawCircle extends StatelessWidget {
  DrawCircle({
    super.key,
  });

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 150),
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: colorsPalette.mainColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(1000),
          ),
        ),
      ),
    );
  }
}
