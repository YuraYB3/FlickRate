import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_snackbar.dart';
import '../../../../common/widgets/my_elevated_button.dart';

class CreateReviewForm extends StatefulWidget {
  final IMovie movie;
  final Function onBackButtonClicked;
  final Function onCrateReviewClicked;
  final Function updateRating;
  final Function updateReview;
  const CreateReviewForm({
    super.key,
    required this.movie,
    required this.onBackButtonClicked,
    required this.onCrateReviewClicked,
    required this.updateRating,
    required this.updateReview,
  });

  @override
  State<CreateReviewForm> createState() => _CreateReviewFormState();
}

class _CreateReviewFormState extends State<CreateReviewForm> {
  @override
  Widget build(BuildContext context) {
    double rat = 0.1;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 400,
        color: mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.movie.movieName.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white, style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Review',
                    labelStyle: TextStyle(color: Colors.white)),
                maxLines: 5,
                onChanged: (value) {
                  widget.updateReview(value);
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Movie rating',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Slider(
                        thumbColor: mainColor,
                        activeColor: secondaryColor,
                        inactiveColor: Colors.white,
                        value: rat,
                        onChanged: (newValue) {
                          setState(() {
                            rat = newValue;
                          });
                          widget.updateRating(newValue);
                        },
                        min: 0.1,
                        max: 10,
                        divisions: 99,
                        label: rat.toStringAsFixed(1),
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyElevatedButton(
                  buttonColor: Colors.white,
                  title: 'CANCEL',
                  width: MediaQuery.of(context).size.width * 0.4,
                  textColor: mainColor,
                  onButtonPressed: () {
                    widget.onBackButtonClicked();
                  },
                ),
                MyElevatedButton(
                  buttonColor: mainColor,
                  title: 'CREATE',
                  width: MediaQuery.of(context).size.width * 0.4,
                  onButtonPressed: () {
                    widget.onCrateReviewClicked(
                        showSuccess: (message) => showCustomSnackBar(
                            context, message, backgroundColor: Colors.green),
                        showException: (message) =>
                            showCustomSnackBar(context, message),
                        movie: widget.movie);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
