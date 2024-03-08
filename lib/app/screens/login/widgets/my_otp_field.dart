import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/color_palette.dart';

class MyOtpField extends StatelessWidget {
  final Function(String value) updateOtpCode;
  MyOtpField({
    super.key,
    required this.updateOtpCode,
  });

  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updateOtpCode(value),
        maxLength: 6,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelStyle: TextStyle(color: colorsPalette.secondColor),
          labelText: 'Code',
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
