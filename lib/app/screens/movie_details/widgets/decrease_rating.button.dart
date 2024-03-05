import 'package:flutter/material.dart';

class DecreaseRatingButton extends StatelessWidget {
  final Function() onButtonClicked;
  const DecreaseRatingButton({
    required this.onButtonClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onButtonClicked,
        icon: const Icon(
          Icons.arrow_upward_sharp,
          color: Colors.grey,
        ));
  }
}
