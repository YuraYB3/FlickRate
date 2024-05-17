import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        decoration:  InputDecoration(
          labelStyle: const TextStyle(color:secondaryColor),
          labelText: AppLocalizations.of(context)!.code,
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
