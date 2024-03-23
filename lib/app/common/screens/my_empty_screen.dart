import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyEmptyScreen extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  MyEmptyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "EMPTY :(",
        style: TextStyle(fontSize: 24, color: colorsPalette.mainColor),
      ),
    );
  }
}
