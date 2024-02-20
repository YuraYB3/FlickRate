import 'package:flickrate/app/theme/color_palete.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/my_text_button.dart';
import '../login_view_model.dart';
import 'enter_code.dart';
import 'enter_number.dart';

class LoginWithPhone extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalete colorsPalete;

  const LoginWithPhone(
      {super.key, required this.model, required this.colorsPalete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!model.isOtpSent)
          EnterNumber(model: model, colorsPalete: colorsPalete),
        if (model.isOtpSent)
          EnterCode(model: model, colorsPalete: colorsPalete),
        const SizedBox(
          height: 20,
        ),
        MyTextButton(
            textColor: colorsPalete.mainColor,
            textSize: 18,
            title: 'Enter with email',
            onButtonPressed: model.switchAutheticationClicked)
      ],
    );
  }
}
