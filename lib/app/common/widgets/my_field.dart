import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyField extends StatelessWidget {
  final String label;
  final Function(String text) onChanged;
  final ColorsPalette colorsPalette = ColorsPalette();
  MyField({required this.label, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: label == 'Password',
        decoration: InputDecoration(
          labelStyle: TextStyle(color: colorsPalette.mainColor),
          labelText: label,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorsPalette.mainColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorsPalette.mainColor),
          ),
        ),
      ),
    );
  }
}
