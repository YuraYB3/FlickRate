import 'package:flickrate/app/common/widgets/my_field.dart';
import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/screens/login/enter_otp/enter_otp_view_model.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../theme/color_palete.dart';
import '../widgets/draw_circle.dart';

class EnterOtpView extends StatelessWidget {
  final EnterOtpViewModel model;
  final INavigationUtil navigationUtil;
  EnterOtpView({required this.navigationUtil, required this.model, super.key});
  final ColorsPalete colorsPalete = ColorsPalete();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Column(
        children: [
          DrawCircle(colorsPalete: colorsPalete),
          const SizedBox(
            height: 80,
          ),
          Text(
            'Enter code',
            style: TextStyle(
              color: colorsPalete.mainColor,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            child: SizedBox(width: 250, child: MyField(label: 'Code')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: MyElevatedButton(
                title: 'APPLY', onButtonPressed: model.onApplyButtonClicked),
          ),
          MyElevatedButton(
              title: "Back", onButtonPressed: navigationUtil.navigateBack),
        ],
      ),
    )));
  }
}
