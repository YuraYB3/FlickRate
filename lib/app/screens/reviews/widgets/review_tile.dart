import 'package:flutter/material.dart';

import '../../../theme/color_palette.dart';

class ReviewTile extends StatefulWidget {
  final String movieName;
  final String rating;

  const ReviewTile({super.key, required this.movieName, required this.rating});

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      title: Text(
        widget.movieName,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.rating,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
