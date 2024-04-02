import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

class DefaultUrlView extends StatelessWidget {
  const DefaultUrlView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ColorsPalette colorsPalette = ColorsPalette();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalette.mainColor,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: const Center(
          child: Text(
            'Hi! \nIm default url page!',
            style: TextStyle(color: Colors.red, fontSize: 36),
          ),
        ),
      ),
    );
  }
}
