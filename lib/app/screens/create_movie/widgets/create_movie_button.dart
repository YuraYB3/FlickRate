import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';

class CreateMovieButton extends StatelessWidget {
  final Function() isFieldsValid;
  final Function() onCreateMovieClicked;
  const CreateMovieButton({
    super.key,
    required this.isFieldsValid,
    required this.onCreateMovieClicked,
  });

  @override
  Widget build(BuildContext context) {
    return MyElevatedButton(
        title: 'Create movie',
        onButtonPressed: () {
          if (isFieldsValid()) {
            onCreateMovieClicked();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please, fill all the fields'),
              ),
            );
          }
        });
  }
}
