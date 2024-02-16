import 'package:flickrate/app/theme/color_palete.dart';
import 'package:flutter/material.dart';

import 'forgot_password_button.dart';
import 'widgets/draw_circle.dart';
import 'widgets/email_field.dart';
import 'widgets/flickrate_text.dart';
import 'widgets/login_buttom.dart';
import 'widgets/password_field.dart';
import 'widgets/signup_button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
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
            EmailField(colorsPalete: colorsPalete),
            PasswordField(colorsPalete: colorsPalete),
            LoginButton(colorsPalete: colorsPalete),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ForgotPasswordButton(),
                  SignUpButton(colorsPalete: colorsPalete)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
