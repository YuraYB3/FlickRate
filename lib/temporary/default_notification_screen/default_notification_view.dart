import 'package:flutter/material.dart';

import '../../app/theme/color_palette.dart';

class DefaultNotificationView extends StatelessWidget {
  const DefaultNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    ColorsPalette colorsPalette = ColorsPalette();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalette.mainColor,
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: const Center(
          child: Text(
            'Hi! \nIm default notification page!',
            style: TextStyle(color: Colors.red, fontSize: 36),
          ),
        ),
      ),
    );
  }
}
