import 'package:flutter/material.dart';


class MyTextButton extends StatelessWidget {
  final Function() onButtonPressed;
  final String title;
  final Color textColor;
  final double textSize;
  const MyTextButton(
      {required this.textColor,
      required this.textSize,
      required this.title,
      required this.onButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: textSize),
      ),
    );
  }
}
