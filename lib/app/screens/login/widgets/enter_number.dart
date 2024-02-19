import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../theme/color_palete.dart';
import '../login_view_model.dart';

class EnterNumber extends StatelessWidget {
  const EnterNumber({
    super.key,
    required this.model,
    required this.colorsPalete,
  });

  final LoginViewModel model;
  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: TextFormField(
            onChanged: (value) => model.updatePhoneNumber(value),
            maxLength: 9,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colorsPalete.mainColor),
              labelText: 'Number',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalete.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalete.mainColor),
              ),
              counterText: '',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MyElevatedButton(title: 'Sent', onButtonPressed: model.sentOtpClicked)
      ],
    );
  }
}
