import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class MyEmailField extends StatelessWidget {
  const MyEmailField({
    super.key,
    required this.updateEmail,
  });

  final Function updateEmail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updateEmail(value),
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelStyle: TextStyle(color: secondaryColor),
          labelText: 'Email',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
          counterText: '',
        ),
      ),
    );
  }
}
