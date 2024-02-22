import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/my_text_button.dart';
import '../../../common/widgets/show_notification.dart';
import '../../../theme/color_palete.dart';
import '../login_view_model.dart';

class LoginWithPhone extends StatelessWidget {
  final LoginViewModel model;
  final ColorsPalete colorsPalete;

  const LoginWithPhone(
      {super.key, required this.model, required this.colorsPalete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!model.isOtpSent)
          EnterPhoneNumberWidget(model: model, colorsPalete: colorsPalete),
        if (model.isOtpSent)
          EnterOtpCodeWidget(model: model, colorsPalete: colorsPalete),
        const SizedBox(
          height: 20,
        ),
        MyTextButton(
            textColor: colorsPalete.mainColor,
            textSize: 18,
            title: 'Sign in with email',
            onButtonPressed: model.switchAutheticationClicked)
      ],
    );
  }
}

class EnterOtpCodeWidget extends StatelessWidget {
  const EnterOtpCodeWidget({
    super.key,
    required this.model,
    required this.colorsPalete,
  });

  final LoginViewModel model;
  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: TextFormField(
            onChanged: (value) => model.updateOtpCode(value),
            maxLength: 6,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelStyle: TextStyle(color: colorsPalete.mainColor),
              labelText: 'Code',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalete.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalete.mainColor),
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
              model.onApplyButtonClicked(
                  showException: (message) =>
                      showNotification(context, message));
            })
      ],
    );
  }
}

class EnterPhoneNumberWidget extends StatelessWidget {
  const EnterPhoneNumberWidget({
    super.key,
    required this.model,
    required this.colorsPalete,
  });

  final LoginViewModel model;
  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: TextFormField(
            onChanged: (value) => model.updatePhoneNumber(value),
            maxLength: 9,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefix: const Text('+380'),
              labelStyle: TextStyle(color: colorsPalete.mainColor),
              labelText: 'Number',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorsPalete.mainColor)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsPalete.mainColor),
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
