import 'package:flutter/material.dart';

import 'home_view_model.dart';
import 'widgets/add_movie_container.dart';
import 'widgets/custom_genre_filter_row.dart';
import 'widgets/custom_grid_view.dart';
import 'widgets/home_app_bar.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel model;
  const HomeView({required this.model, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      height: screenHeight,
      child: Column(
        children: [
          HomeAppBar(),
          AddMovieContainer(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onButtonClicked: widget.model.onAddButtonClicked),
          const SizedBox(
            height: 30,
          ),
          CustomGenreFilterRow(onButtonClicked: widget.model.onShowAllClicked),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: CustomGridView(
            onGenreTileClicked: (genreItem) {
              widget.model.onGenreTileClicked(genreItem);
            },
          )),
        ],
      ),
    ));
  }
}
