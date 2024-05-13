import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class MyPasswordField extends StatelessWidget {
  final Function(String value) updatePassword;
  final String label;

  const MyPasswordField({
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
          labelStyle: const TextStyle(color: secondaryColor),
          labelText: label,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor),
          ),
          counterText: '',
        ),
      ),
    );
  }
}
