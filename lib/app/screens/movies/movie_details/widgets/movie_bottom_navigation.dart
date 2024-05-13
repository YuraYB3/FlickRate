import 'package:flutter/material.dart';

class MovieBottomNavigation extends StatelessWidget {
  final Color activeColor;
  final Color notActiveColor;
  const MovieBottomNavigation({
    super.key,
    required this.activeColor,
    required this.notActiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: notActiveColor,
          ),
        ),
      ],
    );
  }
}
