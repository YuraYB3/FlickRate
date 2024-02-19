import 'package:flickrate/app/common/widgets/my_elevated_button.dart';
import 'package:flickrate/app/common/widgets/my_field.dart';
import 'package:flutter/material.dart';
import '../../theme/color_palete.dart';
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
            if (!model.isOtpSent)
              Column(
                children: [
                  MyField(label: 'Number'),
                  const SizedBox(
                    height: 20,
                  ),
                  MyElevatedButton(
                      title: 'Sent', onButtonPressed: model.sentOtpClicked)
                ],
              ),
            if (model.isOtpSent)
              Column(
                children: [
                  MyField(label: 'Code'),
                  const SizedBox(
                    height: 20,
                  ),
                  MyElevatedButton(
                      title: 'Apply',
                      onButtonPressed: model.onApplyButtonClicked)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
