import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/cached_image.dart';
import '../../../common/widgets/my_loading_widget.dart';
import '../home_view_model.dart';
import 'add_movie_container.dart';
import 'custom_genre_filter_row.dart';
import 'custom_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.model,
    required this.screenHeight,
    required this.screenWidth,
  });

  final HomeViewModel model;
  final double screenHeight;
  final double screenWidth;
  final ColorsPalette colorsPalette = ColorsPalette();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: model.userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MyLoadingWidget();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MyLoadingWidget();
        }
        final userData = snapshot.data!;
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, ${userData.userName} \u{1F44B}",
                      style: TextStyle(
                          fontSize: 24, color: colorsPalette.mainColor),
                    ),
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: CachedImageWidget(
                          imageUrl: userData.userProfileImage,
                          imageSize: 50,
                          shape: BoxShape.circle,
                        ))
                  ],
                )),
            AddMovieContainer(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onButtonClicked: model.onAddButtonClicked,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomGenreFilterRow(
              onButtonClicked: model.onShowAllClicked,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CustomGridView(
                onGenreTileClicked: (genreItem) {
                  model.onGenreTileClicked(genreItem);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
