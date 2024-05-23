import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/widgets/cached_image.dart';
import '../../../theme/color_palette.dart';

class HomeAppBar extends StatelessWidget {
  final String imgURL;
  final String userName;
  const HomeAppBar({super.key, required this.imgURL, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppLocalizations.of(context)!.greeting(userName),
              style: const TextStyle(
                  color: mainColor, fontSize: 28, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: CachedImageWidget(
              imageUrl: imgURL,
              height: 50,
              width: 50,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}
