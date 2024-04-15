// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyElevatedButton extends StatelessWidget {
  final Function() onButtonPressed;
  final String title;
  final double width;
  final Color buttonColor;
  MyElevatedButton(
      {required this.title,
      required this.buttonColor,
      required this.width,
      required this.onButtonPressed,
      super.key});

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
        onPressed: onButtonPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
