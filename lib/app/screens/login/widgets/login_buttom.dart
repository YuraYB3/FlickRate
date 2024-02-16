import 'package:flutter/material.dart';

import '../../../theme/color_palete.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.colorsPalete,
  });

  final ColorsPalete colorsPalete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(colorsPalete.mainColor)),
        onPressed: () {},
        child: const Text('GO'),
      ),
    );
  }
}
