import 'package:flutter/material.dart';

class MovieBottomNavigation extends StatelessWidget {
  final Color activeColor;
  final Color notActiveColor;
  final PageController pageController;
  final Function() moveToNextPage;
  final Function() moveToPreviousPage;
  const MovieBottomNavigation(
      {super.key,
      required this.pageController,
      required this.activeColor,
      required this.notActiveColor,
      required this.moveToNextPage,
      required this.moveToPreviousPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            moveToPreviousPage();
          },
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: activeColor,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            moveToNextPage();
          },
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: notActiveColor,
            ),
          ),
        ),
      ],
    );
  }
}
