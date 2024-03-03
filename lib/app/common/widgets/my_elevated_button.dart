import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyElevatedButton extends StatelessWidget {
  final Function() onButtonPressed;
  final String title;
  final ColorsPalette colorsPalette = ColorsPalette();
  MyElevatedButton(
      {required this.title, required this.onButtonPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(colorsPalette.mainColor)),
        onPressed: onButtonPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
