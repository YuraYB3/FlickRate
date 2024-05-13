import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyLoadingScreen extends StatelessWidget {
  const MyLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    );
  }
}
