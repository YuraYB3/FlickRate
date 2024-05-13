import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class CustomGenreFilterRow extends StatelessWidget {
  final Function() onButtonClicked;
  const CustomGenreFilterRow({
    required this.onButtonClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            "My Reviews",
            style: TextStyle(fontSize: 20, color: mainColor),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: onButtonClicked,
            child: const Text(
              "All",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
