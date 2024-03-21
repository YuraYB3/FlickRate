import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class GenreItem extends StatelessWidget {
  final String title;
  final Function() onTileClicked;
  final ColorsPalette colorsPalette = ColorsPalette();

  GenreItem({super.key, required this.title, required this.onTileClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTileClicked,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                colorsPalette.mainColor.withOpacity(0.5),
                colorsPalette.mainColor.withOpacity(0.9)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
                child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );

    /*InkWell(
      onTap: onTileClicked,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            colorsPalette.mainColor.withOpacity(0.7),
            colorsPalette.mainColor
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );*/
  }
}
