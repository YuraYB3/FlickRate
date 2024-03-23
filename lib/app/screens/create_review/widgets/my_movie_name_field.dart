import 'package:flutter/material.dart';

class MyMovieNameField extends StatelessWidget {
  final double fieldWidth;
  final Function(String value) updateMovieName;
  const MyMovieNameField({
    super.key,
    required this.fieldWidth,
    required this.updateMovieName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      child: TextField(
        onChanged: (value) {
          updateMovieName(value);
        },
        decoration: const InputDecoration(
          labelText: 'Movie name',
        ),
      ),
    );
  }
}
