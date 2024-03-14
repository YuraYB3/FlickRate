import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_email_field.dart';
import '../widgets/my_password_field.dart';

class LoginWithEmailAndPasswordScreen extends StatelessWidget {
  final Function(String value) updateEmail;
  final Function(String value) updatePassword;
  final Function(Function(String message)) onSignInWithEmailAndPasswordClicked;
  final Function() onSwitchToPhoneNumberClicked;
  final Function(Function(String message)) onSignInWithGoogleClicked;
  final Function() onSwitchToSignUpClicked;
  final ColorsPalette colorsPalette = ColorsPalette();

  LoginWithEmailAndPasswordScreen({
    required this.updateEmail,
    super.key,
    required this.updatePassword,
    required this.onSignInWithEmailAndPasswordClicked,
    required this.onSwitchToPhoneNumberClicked,
    required this.onSignInWithGoogleClicked,
    required this.onSwitchToSignUpClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          FlickRateText(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: [
                Text(
                  'Login to your Account',
                  style:
                      TextStyle(color: colorsPalette.secondColor, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyEmailField(updateEmail: updateEmail),
          const SizedBox(
            height: 10,
          ),
          MyPasswordField(label: 'Password', updatePassword: updatePassword),
          const SizedBox(
            height: 10,
          ),
          MyElevatedButton(
              title: "Sign In",
              onButtonPressed: () {
                onSignInWithEmailAndPasswordClicked(
                    (message) => showCustomSnackBar(context, message));
              }),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            'Or sign in with:',
            style: TextStyle(color: colorsPalette.secondColor, fontSize: 16),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 80,
                  child: IconButton(
                      onPressed: onSwitchToPhoneNumberClicked,
                      icon: Icon(
                        Icons.phone_android,
                        color: colorsPalette.mainColor,
                      )),
                ),
                SizedBox(
                  height: 60,
                  width: 80,
                  child: IconButton(
                      onPressed: () {
                        onSignInWithGoogleClicked(
                          (message) => showCustomSnackBar(context, message),
                        );
                      },
                      icon: Text(
                        "G",
                        style: TextStyle(
                            fontSize: 24, color: colorsPalette.mainColor),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Don\'t have an account yet?',
                  style:
                      TextStyle(color: colorsPalette.secondColor, fontSize: 16),
                ),
                MyTextButton(
                    textColor: colorsPalette.mainColor,
                    textSize: 16,
                    title: 'Sign Up',
                    onButtonPressed: onSwitchToSignUpClicked)
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
