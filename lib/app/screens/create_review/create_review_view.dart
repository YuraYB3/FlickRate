import 'package:flickrate/app/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/my_elevated_button.dart';
import '../../theme/color_palette.dart';
import 'create_review_view_model.dart';
import 'widgets/my_descriptions_field.dart';
import 'widgets/my_movie_name_field.dart';

class CreateReviewView extends StatefulWidget {
  final CreateReviewViewModel model;

  const CreateReviewView({required this.model, super.key});

  @override
  State<CreateReviewView> createState() => _CreateReviewViewState();
}

class _CreateReviewViewState extends State<CreateReviewView> {
  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width * 0.8;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPalette.mainColor,
        title: const Text('New Review'),
      ),
      body: SizedBox(
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyMovieNameField(
                fieldWidth: fieldWidth,
                updateMovieName: (value) {
                  widget.model.updateMovieName(value);
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: MyDescriptionField(
                  fieldWidth: fieldWidth,
                  updateMovieDescription: (value) {
                    widget.model.updateMovieDescription(value);
                  },
                ),
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                width: fieldWidth,
                title: 'Create review',
                onButtonPressed: () {
                  widget.model.onCreateReviewClicked(
                    showError: (message) =>
                        showCustomSnackBar(context, message),
                    showSuccess: (message) => showCustomSnackBar(
                        context, message,
                        backgroundColor: Colors.green),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
