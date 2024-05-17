import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';
import '../widgets/draw_circle.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_otp_field.dart';
import '../widgets/my_phone_number_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginWithPhoneNumberPage extends StatelessWidget {
  final bool isOtpSent;
  final Function updatePhoneNumber;
  final Function onSwitchToEmailAndPasswordClicked;
  final Function onApplyOtpCodeButtonClicked;
  final Function updateOtpCode;
  final Function sentOtpClicked;
  const LoginWithPhoneNumberPage({
    super.key,
    required this.updatePhoneNumber,
    required this.sentOtpClicked,
    required this.isOtpSent,
    required this.onSwitchToEmailAndPasswordClicked,
    required this.updateOtpCode,
    required this.onApplyOtpCodeButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawCircle(),
        Container(height: 40),
        const FlickRateText(),
        Container(height: 40),
        if (!isOtpSent)
          Column(
            children: [
              MyPhoneNumberField(updatePhoneNumber: updatePhoneNumber),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                buttonColor: mainColor,
                width: MediaQuery.of(context).size.width * 0.6,
                title: AppLocalizations.of(context)!.send,
                onButtonPressed: () {
                  sentOtpClicked(
                    showException: (message) =>
                        showCustomSnackBar(context, message),
                  );
                },
              ),
            ],
          ),
        if (isOtpSent)
          Column(
            children: [
              MyOtpField(updateOtpCode: updateOtpCode),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                buttonColor: mainColor,
                width: MediaQuery.of(context).size.width * 0.6,
                title: AppLocalizations.of(context)!.apply,
                onButtonPressed: () {
                  onApplyOtpCodeButtonClicked(
                    showException: (message) =>
                        showCustomSnackBar(context, message),
                  );
                },
              )
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        MyTextButton(
          textColor: secondaryColor,
          textSize: 16,
          title: AppLocalizations.of(context)!.back,
          onButtonPressed: () {
            onSwitchToEmailAndPasswordClicked();
          },
        )
      ],
    );
  }
}
