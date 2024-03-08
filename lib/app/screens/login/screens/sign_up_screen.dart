import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/show_notification.dart';
import '../../../theme/color_palette.dart';
import '../widgets/draw_circle.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_email_field.dart';
import '../widgets/my_password_field.dart';

class SignUpScreen extends StatelessWidget {
  final Function(Function(String message)) onRegisterNewUserClicked;
  final Function() onSwitchToEmailAndPasswordClicked;
  final Function(String value) updateEmail;
  final Function(String value) updatePassword;
  final Function(String value) updateRepeatedPassword;
  final ColorsPalette colorsPalette = ColorsPalette();

  SignUpScreen(
      {required this.onRegisterNewUserClicked,
      super.key,
      required this.updateEmail,
      required this.updatePassword,
      required this.onSwitchToEmailAndPasswordClicked,
      required this.updateRepeatedPassword});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawCircle(),
        Container(height: 40),
        FlickRateText(),
        Container(height: 40),
        MyEmailField(updateEmail: updateEmail),
        const SizedBox(
          height: 10,
        ),
        MyPasswordField(label: 'Password', updatePassword: updatePassword),
        const SizedBox(
          height: 10,
        ),
        MyPasswordField(
            label: 'Repeat Password', updatePassword: updateRepeatedPassword),
        const SizedBox(
          height: 10,
        ),
        MyElevatedButton(
            title: "Sign Up",
            onButtonPressed: () {
              onRegisterNewUserClicked(
                  (message) => showNotification(context, message));
            }),
        const SizedBox(
          height: 10,
        ),
        MyTextButton(
            textColor: colorsPalette.secondColor,
            textSize: 16,
            title: 'I already have an account',
            onButtonPressed: onSwitchToEmailAndPasswordClicked)
      ],
    );
  }
}
