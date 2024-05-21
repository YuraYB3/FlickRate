import 'package:flickrate/app/common/widgets/my_loading_widget.dart';
import 'package:flickrate/app/screens/home/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

import 'home_view_model.dart';
import 'widgets/header_movie_holder.dart';
import 'widgets/custom_genre_filter_row.dart';
import 'widgets/custom_grid_view.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel model;
  const HomeScreen({required this.model, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return switch (widget.model.homeState) {
      HomeViewState.loadingInfo => const MyLoadingScreen(),
      HomeViewState.readyToWork => StreamBuilder(
          stream: widget.model.userStream,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting ||
                userSnapshot.hasError) {
              return const MyLoadingScreen();
            }
            final userData = userSnapshot.data!;
            return StreamBuilder(
              stream: widget.model.randomMovieStream,
              builder: (context, movieSnapshot) {
                if (movieSnapshot.connectionState == ConnectionState.waiting ||
                    movieSnapshot.hasError) {
                  return const MyLoadingScreen();
                }
                final movieData = movieSnapshot.data!;
                return Column(
                  children: [
                    HomeAppBar(
                        imgURL: userData.userProfileImage,
                        userName: userData.userName),
                    HeaderMovieHolder(
                      movieId: movieData.documentId,
                      onMovieClicked: widget.model.onMovieClicked,
                      movieImg: movieData.movieImg,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomGenreFilterRow(
                      onButtonClicked: widget.model.onShowAllClicked,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: CustomGridView(
                        onGenreTileClicked: (genreItem) {
                          widget.model.onGenreTileClicked(genreItem);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        )
    };
  }
}
