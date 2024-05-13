import 'package:flickrate/app/common/screens/my_loading_widget.dart';
import 'package:flickrate/app/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../common/screens/my_error_widget.dart';
import '../../common/widgets/cached_image.dart';
import 'home_view_model.dart';
import 'widgets/add_movie_container.dart';
import 'widgets/custom_genre_filter_row.dart';
import 'widgets/custom_grid_view.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel model;
  const HomeScreen({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: model.homeState == HomeViewState.loadingInfo
            ? const MyLoadingScreen()
            : StreamBuilder(
                stream: model.userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const MyErrorScreen();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MyLoadingScreen();
                  }
                  final userData = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 60, left: 20, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hi, ${userData.userName} \u{1F44B}",
                                style: const TextStyle(
                                    fontSize: 24, color: mainColor),
                              ),
                              SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CachedImageWidget(
                                    imageUrl: userData.userProfileImage,
                                    height: 50,
                                    width: 50,
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
              ),
      ),
    );
  }
}
