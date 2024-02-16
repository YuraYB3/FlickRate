import 'package:flutter/material.dart';

import '../../../theme/color_palete.dart';

class DrawCircle extends StatelessWidget {
  const DrawCircle({
    super.key,
    required this.colorsPalete,
  });

  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 150),
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: colorsPalete.mainColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(1000),
          ),
        ),
      ),
    );
  }
}
