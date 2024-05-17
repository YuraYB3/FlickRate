// ignore_for_file: deprecated_member_use

import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HeaderMovieHolder extends StatelessWidget {
  const HeaderMovieHolder({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const CachedImageWidget(
                imageUrl:
                    'https://m.media-amazon.com/images/M/MV5BN2QyZGU4ZDctOWMzMy00NTc5LThlOGQtODhmNDI1NmY5YzAwXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_FMjpg_UX1000_.jpg',
                height: 160,
                shape: BoxShape.rectangle,
                width: double.infinity),
          ),
           Positioned(
            left: 10,
            bottom: 10,
            child: Text(
             AppLocalizations.of(context)!.top_picks.toUpperCase() ,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
