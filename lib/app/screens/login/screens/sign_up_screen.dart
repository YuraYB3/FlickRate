import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../login_view_model.dart';
import '../widgets/draw_circle.dart';
import '../widgets/flickrate_text.dart';

class SignUpScreen extends StatelessWidget {
  final LoginViewModel model;
  final Function() onRegisterNewUserClicked;
  final ColorsPalette colorsPalette = ColorsPalette();

  SignUpScreen({required this.onRegisterNewUserClicked, super.key, required this.model});

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
            title: "Sign Up",
            onButtonPressed: onRegisterNewUserClicked
            )
      ],
    );
  }
}
