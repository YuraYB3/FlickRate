// ignore_for_file: deprecated_member_use

import 'package:flickrate/app/common/widgets/cached_image.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderMovieHolder extends StatelessWidget {
  const HeaderMovieHolder({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.movieImg,
    required this.onMovieClicked,
  });

  final double screenHeight;
  final double screenWidth;
  final String movieImg;
  final Function onMovieClicked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          onMovieClicked();
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedImageWidget(
                imageUrl: movieImg,
                height: 160,
                shape: BoxShape.rectangle,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  color: mainColor.withOpacity(0.8),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.top_picks.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
