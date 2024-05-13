import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyField extends StatelessWidget {
  final String label;
  final Function(String text) onChanged;
  const MyField({required this.label, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: label == 'Password',
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: mainColor),
          labelText: label,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
        ),
      ),
    );
  }
}
