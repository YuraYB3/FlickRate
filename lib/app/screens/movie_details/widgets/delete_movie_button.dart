import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';
import '../../../theme/color_palette.dart';

class DeleteMovieButton extends StatelessWidget {
  DeleteMovieButton({
    super.key,
    required this.onDeleteButtonPressed,
  });

  final ColorsPalette colorsPalette = ColorsPalette();
  final Function() onDeleteButtonPressed;

  @override
  Widget build(BuildContext context) {
    return MyElevatedButton(
        title: "Delete",
        onButtonPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Delete movie"),
                content:
                    const Text("Are you sure you want to delete this movie?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      onDeleteButtonPressed();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: colorsPalette.mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
