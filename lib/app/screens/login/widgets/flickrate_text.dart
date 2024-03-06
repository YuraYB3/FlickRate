import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class FlickRateText extends StatelessWidget {
  FlickRateText({
    super.key,
  });

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return Text(
      'FlickRate',
      style: TextStyle(
        fontSize: 64,
        color: colorsPalette.mainColor,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
