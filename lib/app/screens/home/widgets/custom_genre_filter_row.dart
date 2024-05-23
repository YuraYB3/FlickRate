import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            AppLocalizations.of(context)!.my_reviews.toUpperCase(),
            style: const TextStyle(fontSize: 20, color: mainColor),
          ),
          GestureDetector(
            onTap: onButtonClicked,
            child:  Text(
              AppLocalizations.of(context)!.all.toUpperCase(),
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
