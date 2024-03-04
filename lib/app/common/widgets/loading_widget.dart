import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class LoadingWidget extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: colorsPalette.mainColor,
    );
  }
}
