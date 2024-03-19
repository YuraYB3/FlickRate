import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
