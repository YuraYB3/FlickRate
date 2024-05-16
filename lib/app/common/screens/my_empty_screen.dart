import 'package:flutter/material.dart';
import '../../theme/color_palette.dart';

class MyEmptyScreen extends StatelessWidget {
  final String mainText;
  final String secondaryText;
  const MyEmptyScreen({
    super.key,
    required this.mainText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/comment.png'),
            ),
            Text(
              mainText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            Text(
              secondaryText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
