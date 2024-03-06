import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class MyEmailField extends StatelessWidget {
   MyEmailField({
    super.key,
    required this.updateEmail,
  });

  final Function(String value) updateEmail;
  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updateEmail(value),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: colorsPalette.mainColor),
          labelText: 'Email',
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