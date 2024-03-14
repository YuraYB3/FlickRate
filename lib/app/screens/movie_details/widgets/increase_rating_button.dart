import 'package:flutter/material.dart';

class IncreaseRatingButton extends StatelessWidget {
  final Function() onButtonClicked;
  const IncreaseRatingButton({
    required this.onButtonClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onButtonClicked,
        icon: const Icon(
          Icons.arrow_upward_sharp,
          color: Colors.green,
        ));
  }
}
