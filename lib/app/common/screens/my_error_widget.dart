import 'package:flutter/material.dart';

class MyErrorScreen extends StatelessWidget {
  const MyErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            'ERROR',
            style: TextStyle(color: Colors.red, fontSize: 48),
          ),
        ),
      ),
    );
  }
}
