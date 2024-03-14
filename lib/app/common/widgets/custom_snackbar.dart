import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ColorsPalette colorsPalette = ColorsPalette();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: colorsPalette.mainColor,
    ),
  );
}
