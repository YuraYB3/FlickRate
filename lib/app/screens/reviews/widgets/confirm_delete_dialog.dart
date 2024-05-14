import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Function onConfirm;
  final Function navigateBack;
  final String reviewId;

  const ConfirmDeleteDialog(
      {super.key,
      required this.onConfirm,
      required this.reviewId,
      required this.navigateBack});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure you want to delete this review?',
        style: TextStyle(fontSize: 22),
      ),
      actions: [
        TextButton(
          onPressed: () {
            navigateBack();
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm(reviewId);
            navigateBack();
          },
          child: const Text('Sure', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
