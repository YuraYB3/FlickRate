import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_field.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../theme/color_palette.dart';
import '../login_view_model.dart';

class LoginWithEmailAndPassword extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalette colorsPalette;

  const LoginWithEmailAndPassword(
      {super.key, required this.model, required this.colorsPalette});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyField(
          label: 'Email',
        ),
        const SizedBox(
          height: 20,
        ),
        MyField(
          label: 'Password',
        ),
        const SizedBox(
          height: 20,
        ),
        MyElevatedButton(title: 'Login', onButtonPressed: () {}),
        const SizedBox(
          height: 20,
        ),
        MyTextButton(
            textColor: colorsPalette.mainColor,
            textSize: 16,
            title: 'Sign in with phone number',
            onButtonPressed: model.switchAuthenticationClicked),
        const SizedBox(
          height: 10,
        ),
        MyTextButton(
            textColor: colorsPalette.secondColor,
            textSize: 16,
            title: 'Sign in with google',
            onButtonPressed: model.onSignInWitchGoogleClicked)
      ],
    );
  }
}
