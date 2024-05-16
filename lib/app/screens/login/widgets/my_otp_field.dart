import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/color_palette.dart';

class MyOtpField extends StatelessWidget {
  final Function updateOtpCode;
  const MyOtpField({
    super.key,
    required this.updateOtpCode,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updateOtpCode(value),
        maxLength: 6,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          labelStyle: TextStyle(color:secondaryColor),
          labelText: 'Code',
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
