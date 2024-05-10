import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String title;
  final Function() onButtonTaped;
  const CustomButton({
    super.key,
    required this.title,
    required this.onButtonTaped,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonTaped();
      },
      child: Container(
      height: 100,
        color: buttonColor,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ]),
      ),
    );
  }
}
