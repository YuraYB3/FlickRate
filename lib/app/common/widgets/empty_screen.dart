import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class EmptyScreen extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  EmptyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "EMPTY :(",
      style: TextStyle(fontSize: 24, color: colorsPalette.mainColor),
    );
  }
}
