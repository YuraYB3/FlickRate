import 'package:flutter/material.dart';

class ProfileCustomButton extends StatelessWidget {
  const ProfileCustomButton(
      {super.key,
      required this.onButtonPressed,
      required this.icon,
      required this.buttonText});

  final Function onButtonPressed;
  final IconData icon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
        height: 70,
        width: double.infinity,
        color: Colors.white10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.red,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonText,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
