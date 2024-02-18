import 'package:flickrate/app/common/widgets/my_field.dart';
import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/screens/login/number_verification/number_verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../theme/color_palete.dart';
import '../widgets/draw_circle.dart';

class NumberVerificationView extends StatelessWidget {
  final NumberVerificationViewModel model;
  NumberVerificationView({required this.model, super.key});
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
            'Enter your number',
            style: TextStyle(
              color: colorsPalete.mainColor,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            child: SizedBox(width: 250, child: MyField(label: 'Number')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: MyElevatedButton(
                title: 'Sent', onButtonPressed: model.sentOtpClicked),
          ),
          MyElevatedButton(
              title: "Back",
              onButtonPressed: context.read<INavigationUtil>().navigateBack),
        ],
      ),
    )));
  }
}
