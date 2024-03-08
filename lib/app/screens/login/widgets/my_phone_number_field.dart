import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/color_palette.dart';

class MyPhoneNumberField extends StatelessWidget {
  MyPhoneNumberField({
    super.key,
    required this.updatePhoneNumber,
  });

  final Function(String value) updatePhoneNumber;
  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updatePhoneNumber(value),
        maxLength: 9,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefix: const Text('+380'),
          labelStyle: TextStyle(color: colorsPalette.secondColor),
          labelText: 'Number',
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
