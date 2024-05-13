import 'package:flutter/material.dart';

class ShowReviewBottomSheetButton extends StatefulWidget {
  final Color buttonColor;
  final String title;
  final String movieName;
  final Widget reviewFormWidget;
  const ShowReviewBottomSheetButton({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.movieName,
    required this.reviewFormWidget,
  });

  @override
  State<ShowReviewBottomSheetButton> createState() =>
      _ShowReviewBottomSheetButtonState();
}

class _ShowReviewBottomSheetButtonState
    extends State<ShowReviewBottomSheetButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return widget.reviewFormWidget;
          },
        );
      },
      child: Container(
        height: 80,
        color: widget.buttonColor,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Text(
              widget.title.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ]),
      ),
    );
  }
}
