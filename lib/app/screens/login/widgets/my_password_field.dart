import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class MyPasswordField extends StatelessWidget {
  
  final Function(String value) updatePassword;
  final ColorsPalette colorsPalette = ColorsPalette();

   MyPasswordField({
    super.key,
    required this.updatePassword,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updatePassword(value),
        obscureText: true,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: colorsPalette.mainColor),
          labelText: 'Password',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorsPalette.mainColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorsPalette.mainColor),
          ),
          counterText: '',
        ),
      ),
    );
  }
}