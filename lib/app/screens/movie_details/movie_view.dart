import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../common/widgets/my_elevated_button.dart';
import '../../theme/color_palette.dart';
import 'movie_view_model.dart';

class MovieView extends StatelessWidget {
  final MovieViewModel _model;
  final ColorsPalette colorsPalette = ColorsPalette();

  MovieView({Key? key, required MovieViewModel model})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<IMovie>(
      stream: _model.movieStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('ERROR'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: colorsPalette.mainColor,
            ),
          );
        }
        final movieData = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
              title: Text(movieData.name),
              backgroundColor: colorsPalette.mainColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    movieData.rating.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                )
              ]),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.4,
                    width: screenWidth,
                    color: Colors.grey[800],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: SizedBox(child: Text(movieData.description)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            _model.onDecreaseButtonClicked(movieData.id);
                          },
                          icon: const Icon(
                            Icons.arrow_downward_sharp,
                            color: Colors.grey,
                          )),
                      MyElevatedButton(
                          title: "Delete",
                          onButtonPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete movie"),
                                  content: const Text(
                                      "Are you sure you want to delete this movie?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _model.onDeleteButtonPressed(
                                            movieData.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: colorsPalette.mainColor),
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
                          }),
                      IconButton(
                          onPressed: () {
                            _model.onIncreaseButtonClicked(movieData.id);
                          },
                          icon: const Icon(
                            Icons.arrow_upward_sharp,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
