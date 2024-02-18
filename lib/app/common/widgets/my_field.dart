import 'package:flutter/material.dart';

import '../../theme/color_palete.dart';

class MyField extends StatelessWidget {
  final String label;
  final ColorsPalete colorsPalete = ColorsPalete();
  MyField({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        obscureText: label == 'Password',
        decoration: InputDecoration(
          labelStyle: TextStyle(color: colorsPalete.mainColor),
          labelText: label,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorsPalete.mainColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorsPalete.mainColor),
          ),
        ),
      ),
    );
  }
}
