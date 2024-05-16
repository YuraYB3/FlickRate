import 'package:flutter/material.dart';

import 'login_view_model.dart';
import 'pages/login_with_email_and_pass_screen.dart';
import 'pages/login_with_phone_number_screen.dart';
import 'pages/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel model;

  const LoginScreen({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: switch (model.loginMethod) {
        LoginState.loginWithPhoneNumber => LoginWithPhoneNumberPage(
            isOtpSent: model.isOtpSent,
            updateOtpCode: model.updateOtpCode,
            sentOtpClicked: model.sentOtpClicked,
            updatePhoneNumber: model.updatePhoneNumber,
            onSwitchToEmailAndPasswordClicked:
                model.onSwitchToEmailAndPasswordClicked,
            onApplyOtpCodeButtonClicked: model.onApplyOtpCodeButtonClicked,
          ),
        LoginState.loginWithEmailAndPassword => LoginWithEmailAndPasswordPage(
            updateEmail: model.updateEmail,
            updatePassword: model.updatePassword,
            onSignInWithEmailAndPasswordClicked:
                model.onSignInWithEmailAndPasswordClicked,
            onSwitchToPhoneNumberClicked: model.onSwitchToPhoneNumberClicked,
            onSignInWithGoogleClicked: model.onSignInWithGoogleClicked,
            onSwitchToSignUpClicked: model.onSwitchToSignUpClicked,
          ),
        LoginState.registerNewAccount => SignUpPage(
            updateRepeatedPassword: model.updateRepeatedPassword,
            updateEmail: model.updateEmail,
            updatePassword: model.updatePassword,
            onRegisterNewUserClicked: model.onRegisterNewUserClicked,
            onSwitchToEmailAndPasswordClicked:
                model.onSwitchToEmailAndPasswordClicked,
          )
      }),
    );
  }
}
