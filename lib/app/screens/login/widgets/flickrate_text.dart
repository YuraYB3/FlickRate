import 'package:flutter/material.dart';

import '../../../theme/color_palete.dart';

class FlicrRateText extends StatelessWidget {
  const FlicrRateText({
    super.key,
    required this.colorsPalete,
  });

  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return Text(
      'FlickRate',
      style: TextStyle(
        fontSize: 64,
        color: colorsPalete.mainColor,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
