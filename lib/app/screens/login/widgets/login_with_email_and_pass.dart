import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../theme/color_palette.dart';
import '../login_view_model.dart';
import 'draw_circle.dart';
import 'flickrate_text.dart';

class LoginWithEmailAndPassword extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalette colorsPalette = ColorsPalette();

  LoginWithEmailAndPassword({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawCircle(),
        Container(height: 40),
        FlickRateText(),
        Container(height: 40),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            onChanged: (value) => model.updateEmail(value),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colorsPalette.mainColor),
              labelText: 'Email',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalette.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalette.mainColor),
              ),
              counterText: '',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            onChanged: (value) => model.updatePassword(value),
            obscureText: true,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colorsPalette.mainColor),
              labelText: 'Password',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalette.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalette.mainColor),
              ),
              counterText: '',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MyElevatedButton(
            title: "Sign In",
            onButtonPressed: () {
              model.onSignInWithEmailAndPasswordClicked();
            }),
        const SizedBox(
          height: 10,
        ),
        MyTextButton(
            textColor: colorsPalette.mainColor,
            textSize: 16,
            title: 'Sign in with phone number',
            onButtonPressed: model.onSwitchToPhoneNumberClicked),
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
                  onButtonPressed: model.onSignInWithGoogleClicked),
              Expanded(child: Container()),
              MyTextButton(
                  textColor: Colors.green,
                  textSize: 16,
                  title: 'Sign Up',
                  onButtonPressed: model.onSwitchToSignUpClicked)
            ],
          ),
        )
      ],
    );
  }
}
