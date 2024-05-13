import 'package:flutter/material.dart';

import '../../theme/color_palette.dart';

class MyEmptyScreen extends StatelessWidget {
  const MyEmptyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "EMPTY :(",
        style: TextStyle(fontSize: 24, color: mainColor),
      ),
    );
  }
}
