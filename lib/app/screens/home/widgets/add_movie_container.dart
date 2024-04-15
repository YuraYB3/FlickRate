// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class AddMovieContainer extends StatelessWidget {
  final ColorsPalette colorsPalette = ColorsPalette();
  final Function() onButtonClicked;
  AddMovieContainer({
    super.key,
    required this.onButtonClicked,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                colorsPalette.mainColor.withOpacity(0.6),
                colorsPalette.mainColor.withOpacity(0.9)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              height: screenHeight * 0.3,
              width: screenWidth,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      "Have you watched new movie? ",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        SizedBox(
                            width: 200,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                                onPressed: onButtonClicked,
                                child: Text(
                                  "Write review",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: colorsPalette.mainColor),
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
