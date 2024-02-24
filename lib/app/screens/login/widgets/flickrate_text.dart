import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class FlickRateText extends StatelessWidget {
  const FlickRateText({
    super.key,
    required this.colorsPalette,
  });

  final ColorsPalette colorsPalette;

  @override
  Widget build(BuildContext context) {
    return Text(
      'FlickRate',
      style: TextStyle(
        fontSize: 64,
        color: colorsPalette.secondColor,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
