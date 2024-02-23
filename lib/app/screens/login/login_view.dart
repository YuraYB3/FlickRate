import 'package:flutter/material.dart';

import '../../theme/color_palete.dart';
import 'login_view_model.dart';
import 'widgets/draw_circle.dart';
import 'widgets/flickrate_text.dart';
import 'widgets/login_with_email_and_pass.dart';
import 'widgets/login_with_phone.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalete colorsPalete = ColorsPalete();

  LoginView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DrawCircle(colorsPalete: colorsPalete),
            Container(height: 40),
            FlicrRateText(colorsPalete: colorsPalete),
            Container(height: 40),
            if (!model.isLoginWithNumberClicked)
              LoginWithEmailAndPassword(
                  model: model, colorsPalete: colorsPalete),
            if (model.isLoginWithNumberClicked)
              LoginWithPhone(model: model, colorsPalete: colorsPalete)
          ],
        ),
      ),
    );
  }
}
