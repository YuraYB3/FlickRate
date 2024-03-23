import 'package:flutter/material.dart';

class MyDescriptionField extends StatelessWidget {
  final double fieldWidth;
  final Function(String value) updateMovieDescription;
  const MyDescriptionField({
    super.key,
    required this.fieldWidth,
    required this.updateMovieDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      child: TextField(
        maxLines: 20,
        onChanged: (value) {
          updateMovieDescription(value);
        },
        decoration: const InputDecoration(
          labelText: 'Review',
        ),
      ),
    );
  }
}
