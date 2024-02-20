import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../common/widgets/show_notification.dart';
import '../../../theme/color_palete.dart';
import '../login_view_model.dart';

class EnterCode extends StatelessWidget {
  const EnterCode({
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
