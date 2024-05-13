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
            updateOtpCode: (value) {
              model.updateOtpCode(value);
            },
            sentOtpClicked: (p0) {
              model.sentOtpClicked(showException: p0);
            },
            updatePhoneNumber: (value) {
              model.updatePhoneNumber(value);
            },
            onSwitchToEmailAndPasswordClicked:
                model.onSwitchToEmailAndPasswordClicked,
            onApplyOtpCodeButtonClicked: (p0) {
              model.onApplyOtpCodeButtonClicked(showException: p0);
            },
          ),
        LoginState.loginWithEmailAndPassword => LoginWithEmailAndPasswordPage(
            updateEmail: (value) {
              model.updateEmail(value);
            },
            updatePassword: (value) {
              model.updatePassword(value);
            },
            onSignInWithEmailAndPasswordClicked: (p0) {
              model.onSignInWithEmailAndPasswordClicked(showException: p0);
            },
            onSwitchToPhoneNumberClicked: model.onSwitchToPhoneNumberClicked,
            onSignInWithGoogleClicked: (p0) {
              model.onSignInWithGoogleClicked(showException: p0);
            },
            onSwitchToSignUpClicked: model.onSwitchToSignUpClicked,
          ),
        LoginState.registerNewAccount => SignUpPage(
            updateRepeatedPassword: (value) {
              model.updateRepeatedPassword(value);
            },
            updateEmail: (value) {
              model.updateEmail(value);
            },
            updatePassword: (value) {
              model.updatePassword(value);
            },
            onRegisterNewUserClicked: (p0) {
              model.onRegisterNewUserClicked(showException: p0);
            },
            onSwitchToEmailAndPasswordClicked:
                model.onSwitchToEmailAndPasswordClicked,
          )
      }),
    );
  }
}
