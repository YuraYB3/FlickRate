import 'package:flickrate/app/screens/login/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';
import 'widgets/login_with_email_and_pass.dart';
import 'widgets/login_with_phone.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel model;

  const LoginView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: switch (model.loginMethod) {
        LoginState.loginWithPhoneNumber => LoginWithPhone(model: model),
        LoginState.loginWithEmailAndPassword =>
          LoginWithEmailAndPassword(model: model),
        LoginState.registerNewAccount => SignUpWidget(
            model: model,
          )
      }),
    );
  }
}
