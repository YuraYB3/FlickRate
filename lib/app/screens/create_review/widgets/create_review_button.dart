import 'package:flutter/material.dart';

import '../../../common/widgets/my_elevated_button.dart';

class CreateMovieButton extends StatelessWidget {
  final Function() onCreateMovieClicked;
  const CreateMovieButton({
    super.key,
    required this.onCreateMovieClicked,
  });

  @override
  Widget build(BuildContext context) {
    return MyElevatedButton(
        title: 'Create review', onButtonPressed: onCreateMovieClicked);
  }
}
