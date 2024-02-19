import 'package:flutter/material.dart';
import '../../theme/color_palete.dart';
import 'login_view_model.dart';
import 'widgets/draw_circle.dart';
import 'widgets/enter_code.dart';
import 'widgets/enter_number.dart';
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
            if (!model.isOtpSent)
              EnterNumber(model: model, colorsPalete: colorsPalete),
            if (model.isOtpSent)
              EnterCode(model: model, colorsPalete: colorsPalete),
          ],
        ),
      ),
    );
  }
}
