import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        decoration:  InputDecoration(
          labelStyle: const TextStyle(color: secondaryColor),
          labelText: AppLocalizations.of(context)!.email,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
          counterText: '',
        ),
      ),
    );
  }
}
