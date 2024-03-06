import 'package:flickrate/app/screens/login/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

import 'login_view_model.dart';
import 'screens/login_with_email_and_pass_screen.dart';
import 'screens/login_with_phone_number_screen.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel model;

  const LoginView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: switch (model.loginMethod) {
        LoginState.loginWithPhoneNumber => LoginWithPhoneNumberScreen(model: model),
        LoginState.loginWithEmailAndPassword =>
          LoginWithEmailAndPasswordScreen(
           updateEmail: (value) {
           model.updateEmail(value);},
           updatePassword: ( value) { model.updatePassword(value); },
           onSignInWithEmailAndPasswordClicked: model.onSignInWithEmailAndPasswordClicked,
           onSwitchToPhoneNumberClicked: model.onSwitchToPhoneNumberClicked,
           onSignInWithGoogleClicked: model.onSignInWithGoogleClicked,
           onSwitchToSignUpClicked: model.onSwitchToSignUpClicked,),
        LoginState.registerNewAccount => SignUpScreen(
            model: model,
            onRegisterNewUserClicked: model.onRegisterNewUserClicked,
          )
      }),
    );
  }
}
