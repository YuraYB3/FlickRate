import 'package:flutter/material.dart';

import '../../../theme/color_palete.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.colorsPalete,
  });

  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: SizedBox(
        width: 250,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: colorsPalete.mainColor),
            labelText: 'Password',
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorsPalete.mainColor)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorsPalete.mainColor),
            ),
          ),
        ),
      ),
    );
  }
}
