import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/custom_snackbar.dart';
import '../../../theme/color_palette.dart';
import '../widgets/draw_circle.dart';
import '../widgets/flickrate_text.dart';
import '../widgets/my_otp_field.dart';
import '../widgets/my_phone_number_field.dart';

class LoginWithPhoneNumberScreen extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final bool isOtpSent;
  final Function(String value) updatePhoneNumber;
  final Function() onSwitchToEmailAndPasswordClicked;
  final Function(Function(String message)) onApplyOtpCodeButtonClicked;
  final Function(String value) updateOtpCode;
  final Function(Function(String message)) sentOtpClicked;
  LoginWithPhoneNumberScreen({
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
        DrawCircle(),
        Container(height: 40),
        FlickRateText(),
        Container(height: 40),
        if (!isOtpSent)
          Column(
            children: [
              MyPhoneNumberField(updatePhoneNumber: updatePhoneNumber),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                  buttonColor: colorsPalette.mainColor,
                  width: MediaQuery.of(context).size.width * 0.6,
                  title: 'Sent',
                  onButtonPressed: () {
                    sentOtpClicked(
                        (message) => showCustomSnackBar(context, message));
                  }),
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
                  buttonColor: colorsPalette.mainColor,
                  width: MediaQuery.of(context).size.width * 0.6,
                  title: 'Apply',
                  onButtonPressed: () {
                    onApplyOtpCodeButtonClicked(
                        (message) => showCustomSnackBar(context, message));
                  })
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        MyTextButton(
            textColor: colorsPalette.secondColor,
            textSize: 16,
            title: 'Back',
            onButtonPressed: onSwitchToEmailAndPasswordClicked)
      ],
    );
  }
}
