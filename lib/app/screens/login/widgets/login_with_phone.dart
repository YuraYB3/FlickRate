import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/show_notification.dart';
import '../../../theme/color_palette.dart';
import '../login_view_model.dart';
import 'draw_circle.dart';
import 'flickrate_text.dart';

class LoginWithPhone extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalette colorsPalette = ColorsPalette();

  LoginWithPhone({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawCircle(),
        Container(height: 40),
        FlickRateText(),
        Container(height: 40),
        if (!model.isOtpSent)
          EnterPhoneNumberWidget(model: model, colorsPalette: colorsPalette),
        if (model.isOtpSent)
          EnterOtpCodeWidget(model: model, colorsPalette: colorsPalette),
        const SizedBox(
          height: 20,
        ),
        MyTextButton(
            textColor: colorsPalette.mainColor,
            textSize: 18,
            title: 'Sign in with email',
            onButtonPressed: model.onSwitchToEmailAndPasswordClicked)
      ],
    );
  }
}

class EnterPhoneNumberWidget extends StatelessWidget {
  const EnterPhoneNumberWidget({
    super.key,
    required this.model,
    required this.colorsPalette,
  });

  final LoginViewModel model;
  final ColorsPalette colorsPalette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            onChanged: (value) => model.updatePhoneNumber(value),
            maxLength: 9,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefix: const Text('+380'),
              labelStyle: TextStyle(color: colorsPalette.mainColor),
              labelText: 'Number',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalette.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalette.mainColor),
              ),
              counterText: '',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MyElevatedButton(
            title: 'Sent',
            onButtonPressed: () {
              model.sentOtpClicked(
                  showException: (message) =>
                      showNotification(context, message));
            })
      ],
    );
  }
}

class EnterOtpCodeWidget extends StatelessWidget {
  const EnterOtpCodeWidget({
    super.key,
    required this.model,
    required this.colorsPalette,
  });

  final LoginViewModel model;
  final ColorsPalette colorsPalette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            onChanged: (value) => model.updateOtpCode(value),
            maxLength: 6,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colorsPalette.mainColor),
              labelText: 'Code',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalette.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalette.mainColor),
              ),
              counterText: '',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MyElevatedButton(
            title: 'Apply',
            onButtonPressed: () {
              model.onApplyOtpCodeButtonClicked(
                  showException: (message) =>
                      showNotification(context, message));
            })
      ],
    );
  }
}
