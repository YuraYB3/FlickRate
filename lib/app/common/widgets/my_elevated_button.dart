import 'package:flickrate/app/theme/color_palete.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Function() onButtonPressed;
  final String title;
  final ColorsPalete colorsPalete = ColorsPalete();
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
                MaterialStateProperty.all<Color>(colorsPalete.mainColor)),
        onPressed: onButtonPressed,
        child: Text(title),
      ),
    );
  }
}
