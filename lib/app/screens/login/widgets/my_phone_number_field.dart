import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyPhoneNumberField extends StatelessWidget {
  const MyPhoneNumberField({
    super.key,
    required this.updatePhoneNumber,
  });

  final Function updatePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        onChanged: (value) => updatePhoneNumber(value),
        maxLength: 9,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.phone,
        decoration:  InputDecoration(
          prefix: const Text('+380'),
          labelStyle: const TextStyle(color: secondaryColor),
          labelText: AppLocalizations.of(context)!.number,
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
