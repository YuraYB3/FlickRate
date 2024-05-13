// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Function() onButtonPressed;
  final String title;
  final double width;
  final Color buttonColor;
  final Color textColor;
  const MyElevatedButton(
      {required this.title,
      required this.buttonColor,
      required this.width,
      required this.onButtonPressed,
      this.textColor = Colors.white,
      super.key});

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
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
