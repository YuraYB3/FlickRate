import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyLoadingScreen extends StatelessWidget {
  MyLoadingScreen({Key? key}) : super(key: key);

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: colorsPalette.mainColor,
      ),
    );
  }
}
