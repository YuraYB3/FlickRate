import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class FlickRateText extends StatelessWidget {
  const FlickRateText({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return const Text(
      'FlickRate',
      style: TextStyle(
        fontSize: 64,
        color: mainColor,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
