import 'package:flickrate/app/screens/login/widgets/login_with_email_and_pass.dart';
import 'package:flickrate/app/screens/login/widgets/login_with_phone.dart';
import 'package:flutter/material.dart';

import '../../../theme/color_palete.dart';
import '../login_view_model.dart';

class Login extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalete colorsPalete;

  const Login({super.key, required this.model, required this.colorsPalete});

  @override
  Widget build(BuildContext context) {
    if (!model.isLoginWithNumberClicked) {
      return LoginWithEmailAndPassword(
          model: model, colorsPalete: colorsPalete);
    } else {
      return LoginWithPhone(model: model, colorsPalete: colorsPalete);
    }
  }
}
