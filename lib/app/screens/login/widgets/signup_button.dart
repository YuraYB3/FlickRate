import 'package:flutter/material.dart';

import '../../../theme/color_palete.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.colorsPalete,
  });

  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Text(
          'Sign Up',
          style: TextStyle(color: colorsPalete.mainColor),
        ));
  }
}
