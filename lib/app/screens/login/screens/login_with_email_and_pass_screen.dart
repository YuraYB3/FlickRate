import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../theme/color_palette.dart';
import '../widgets/draw_circle.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_email_field.dart';
import '../widgets/my_password_field.dart';

class LoginWithEmailAndPasswordScreen extends StatelessWidget {
  final Function(String value) updateEmail;
  final Function(String value) updatePassword;
  final Function() onSignInWithEmailAndPasswordClicked;
  final Function() onSwitchToPhoneNumberClicked;
  final Function() onSignInWithGoogleClicked;
  final Function()  onSwitchToSignUpClicked;
  final ColorsPalette colorsPalette = ColorsPalette();

  LoginWithEmailAndPasswordScreen({ required this.updateEmail, super.key, required this.updatePassword, required this.onSignInWithEmailAndPasswordClicked, required this.onSwitchToPhoneNumberClicked, required this.onSignInWithGoogleClicked, required this.onSwitchToSignUpClicked,});

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
        MyPasswordField(updatePassword: updatePassword),
        const SizedBox(
          height: 10,
        ),
        MyElevatedButton(
            title: "Sign In",
            onButtonPressed: () {
              onSignInWithEmailAndPasswordClicked();
            }),
        const SizedBox(
          height: 10,
        ),
        MyTextButton(
            textColor: colorsPalette.mainColor,
            textSize: 16,
            title: 'Sign in with phone number',
            onButtonPressed: onSwitchToPhoneNumberClicked),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            children: [
              MyTextButton(
                  textColor: colorsPalette.secondColor,
                  textSize: 16,
                  title: 'Google',
                  onButtonPressed: onSignInWithGoogleClicked),
              Expanded(child: Container()),
              MyTextButton(
                  textColor: Colors.green,
                  textSize: 16,
                  title: 'Sign Up',
                  onButtonPressed: onSwitchToSignUpClicked)
            ],
          ),
        )
      ],
    );
  }
}




