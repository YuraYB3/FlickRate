import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_email_field.dart';
import '../widgets/my_password_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginWithEmailAndPasswordPage extends StatelessWidget {
  final Function updateEmail;
  final Function updatePassword;
  final Function onSignInWithEmailAndPasswordClicked;
  final Function onSwitchToPhoneNumberClicked;
  final Function onSignInWithGoogleClicked;
  final Function onSwitchToSignUpClicked;

  const LoginWithEmailAndPasswordPage({
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
          const FlickRateText(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child:  Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(color: secondaryColor, fontSize: 18),
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
          MyPasswordField(label: AppLocalizations.of(context)!.password, updatePassword: updatePassword),
          const SizedBox(
            height: 10,
          ),
          MyElevatedButton(
              title: AppLocalizations.of(context)!.sign_in,
              buttonColor: mainColor,
              width: MediaQuery.of(context).size.width * 0.6,
              onButtonPressed: () {
                onSignInWithEmailAndPasswordClicked(
                  showException: (message) =>
                      showCustomSnackBar(context, message),
                );
              }),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
           Text(
           AppLocalizations.of(context)!.other_type_of_login,
            style: const TextStyle(color: secondaryColor, fontSize: 16),
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
                      onPressed: () {
                        onSwitchToPhoneNumberClicked();
                      },
                      icon: const Icon(
                        Icons.phone_android,
                        color: mainColor,
                      )),
                ),
                SizedBox(
                  height: 60,
                  width: 80,
                  child: IconButton(
                    onPressed: () {
                      onSignInWithGoogleClicked(
                        showException: (message) =>
                            showCustomSnackBar(context, message),
                      );
                    },
                    icon: const Text(
                      "G",
                      style: TextStyle(fontSize: 24, color: mainColor),
                    ),
                  ),
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
                AppLocalizations.of(context)!.ask_about_account ,
                  style: const TextStyle(color: secondaryColor, fontSize: 16),
                ),
                MyTextButton(
                  textColor: mainColor,
                  textSize: 16,
                  title: AppLocalizations.of(context)!.sign_up,
                  onButtonPressed: () {
                    onSwitchToSignUpClicked();
                  },
                )
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
