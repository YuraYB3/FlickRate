import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class ActionsInfoWidget extends StatelessWidget {
  ActionsInfoWidget(
      {super.key, required this.reviewCount, required this.userLikes});
  final ColorsPalette colorsPalette = ColorsPalette();
  final String reviewCount;
  final String userLikes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              reviewCount,
              style: TextStyle(color: colorsPalette.mainColor, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('Reviews', style: TextStyle(color: colorsPalette.secondColor)),
          ],
        ),
        Column(
          children: [
            Text(
              userLikes,
              style: TextStyle(color: colorsPalette.mainColor, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Likes',
              style: TextStyle(color: colorsPalette.secondColor),
            ),
          ],
        )
      ],
    );
  }
}
