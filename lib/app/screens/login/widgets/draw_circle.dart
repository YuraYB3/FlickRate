import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class DrawCircle extends StatelessWidget {
  const DrawCircle({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 150),
      child: Container(
        height: 200,
        width: 300,
        decoration: const BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(1000),
          ),
        ),
      ),
    );
  }
}
