import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/color_palette.dart';

class MyPhoneNumberField extends StatelessWidget {
  const MyPhoneNumberField({
    super.key,
    required this.updatePhoneNumber,
  });

  final Function(String value) updatePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updatePhoneNumber(value),
        maxLength: 9,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          prefix: Text('+380'),
          labelStyle: TextStyle(color: secondaryColor),
          labelText: 'Number',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor),
          ),
          counterText: '',
        ),
      ),
    );
  }
}
