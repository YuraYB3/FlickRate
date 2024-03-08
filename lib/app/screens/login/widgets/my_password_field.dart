import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class MyPasswordField extends StatelessWidget {
  final Function(String value) updatePassword;
  final ColorsPalette colorsPalette = ColorsPalette();
  final String label;

  MyPasswordField({
    super.key,
    required this.updatePassword,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updatePassword(value),
        obscureText: true,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: colorsPalette.secondColor),
          labelText: label,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorsPalette.secondColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorsPalette.secondColor),
          ),
          counterText: '',
        ),
      ),
    );
  }
}
