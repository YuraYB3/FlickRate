import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/common/widgets/my_field.dart';
import 'package:flickrate/app/common/widgets/my_text_button.dart';
import 'package:flickrate/app/theme/color_palete.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';
import 'widgets/draw_circle.dart';
import 'widgets/flickrate_text.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel model;

  LoginView({required this.model, Key? key}) : super(key: key);
  final ColorsPalete colorsPalete = ColorsPalete();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DrawCircle(colorsPalete: colorsPalete),
            Container(height: 60),
            FlicrRateText(colorsPalete: colorsPalete),
            Container(height: 50),
            MyField(label: 'Email'),
            const SizedBox(height: 20),
            MyField(label: 'Password'),
            const SizedBox(height: 20),
            MyElevatedButton(title: 'GO', onButtonPressed: () {}),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextButton(
                    textColor: colorsPalete.mainColor,
                    textSize: 14,
                    title: 'Sign in with phone',
                    onButtonPressed: model.onSignInWithNumberButtonPressed,
                  ),
                  MyTextButton(
                      textColor: Colors.black,
                      textSize: 14,
                      title: 'Sign up ',
                      onButtonPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
