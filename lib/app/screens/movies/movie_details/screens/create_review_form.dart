import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/my_elevated_button.dart';

class CreateReviewForm extends StatefulWidget {
  final String movieName;
  final double rating;
  final Function(double value) updateRating;
  final Function(String value) updateReview;
  final Function() onCrateReviewClicked;
  const CreateReviewForm(
      {super.key,
      required this.movieName,
      required this.rating,
      required this.updateRating,
      required this.onCrateReviewClicked,
      required this.updateReview});

  @override
  State<CreateReviewForm> createState() => _CreateReviewFormState();
}

class _CreateReviewFormState extends State<CreateReviewForm> {
  ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Text(
              'Write your review about',
              style: TextStyle(
                  color: colorsPalette.mainColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.movieName.toUpperCase(),
              style: TextStyle(
                  color: colorsPalette.secondColor,
                  fontSize: 72,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Review',
              ),
              maxLines: 10,
              onChanged: (value) {
                widget.updateReview(value);
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Movie rating',
                  style: TextStyle(fontSize: 16),
                ),
                Slider(
                  thumbColor: colorsPalette.mainColor,
                  activeColor: colorsPalette.mainColor,
                  inactiveColor: colorsPalette.secondColor,
                  value: widget.rating,
                  onChanged: (newValue) {
                    widget.updateRating(newValue);
                  },
                  min: 0.1,
                  max: 10,
                  divisions: 99,
                  label: widget.rating.toStringAsFixed(1),
                ),
              ],
            ),
            MyElevatedButton(
              buttonColor: colorsPalette.mainColor,
              title: 'Create',
              width: double.infinity,
              onButtonPressed: () {
                widget.onCrateReviewClicked();
              },
            ),
          ],
        ),
      ),
    );
  }
}
