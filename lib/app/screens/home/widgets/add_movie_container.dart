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
      child: Container(
        height: screenHeight * 0.3,
        width: screenWidth,
        decoration: BoxDecoration(
            color: colorsPalette.mainColor,
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              const Text(
                "Have you watched new movie? ",
                style: TextStyle(color: Colors.white, fontSize: 34),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(child: Container()),
                  SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: onButtonClicked,
                          child: Text(
                            "Add",
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
    );
  }
}
