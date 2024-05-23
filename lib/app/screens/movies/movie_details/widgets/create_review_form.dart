import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Flexible(
              child: Text(
                widget.movie.movieName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white, style: BorderStyle.solid),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: AppLocalizations.of(context)!.review,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
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
                  Text(
                    AppLocalizations.of(context)!.movie_rating,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
                        max: 5,
                        divisions: 49,
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
                  title: AppLocalizations.of(context)!.cancel.toUpperCase(),
                  width: MediaQuery.of(context).size.width * 0.4,
                  textColor: mainColor,
                  onButtonPressed: () {
                    widget.onBackButtonClicked();
                  },
                ),
                MyElevatedButton(
                  buttonColor: mainColor,
                  title: AppLocalizations.of(context)!.create.toUpperCase(),
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
