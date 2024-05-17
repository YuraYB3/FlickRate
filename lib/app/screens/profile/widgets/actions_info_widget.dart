import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../theme/color_palette.dart';

class ActionsInfoWidget extends StatelessWidget {
  const ActionsInfoWidget(
      {super.key, required this.reviewCount, required this.userLikes});
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
              style: const TextStyle(color: mainColor, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
             Text(AppLocalizations.of(context)!.reviews, style: const TextStyle(color: secondaryColor)),
          ],
        ),
       
      ],
    );
  }
}
