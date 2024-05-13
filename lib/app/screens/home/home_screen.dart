import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/app/screens/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

import '../../common/screens/my_error_widget.dart';
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
                      HomeAppBar(
                          imgURL: userData.userProfileImage,
                          userName: userData.userName),
                      AddMovieContainer(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
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
