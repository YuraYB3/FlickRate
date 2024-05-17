import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';
import '../widgets/draw_circle.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_email_field.dart';
import '../widgets/my_password_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpPage extends StatelessWidget {
  final Function onRegisterNewUserClicked;
  final Function onSwitchToEmailAndPasswordClicked;
  final Function updateEmail;
  final Function updatePassword;
  final Function updateRepeatedPassword;

  const SignUpPage(
      {required this.onRegisterNewUserClicked,
      super.key,
      required this.updateEmail,
      required this.updatePassword,
      required this.onSwitchToEmailAndPasswordClicked,
      required this.updateRepeatedPassword});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawCircle(),
        Container(height: 40),
        const FlickRateText(),
        Container(height: 40),
        MyEmailField(updateEmail: updateEmail),
        const SizedBox(
          height: 10,
        ),
        MyPasswordField(label: AppLocalizations.of(context)!.password, updatePassword: updatePassword),
        const SizedBox(
          height: 10,
        ),
        MyPasswordField(
            label: AppLocalizations.of(context)!.repeat_password, updatePassword: updateRepeatedPassword),
        const SizedBox(
          height: 10,
        ),
        MyElevatedButton(
          buttonColor: mainColor,
          width: MediaQuery.of(context).size.width * 0.6,
          title: AppLocalizations.of(context)!.sign_up,
          onButtonPressed: () {
            onRegisterNewUserClicked(
              showException: (message) => showCustomSnackBar(context, message),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        MyTextButton(
          textColor: secondaryColor,
          textSize: 16,
          title: AppLocalizations.of(context)!.have_account,
          onButtonPressed: () {
            onSwitchToEmailAndPasswordClicked();
          },
        )
      ],
    );
  }
}
