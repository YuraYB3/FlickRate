import 'package:flutter/material.dart';

import '../../../data/genre/movie_genre.dart';
import '../../theme/color_palette.dart';
import 'home_view_model.dart';
import 'widgets/add_movie_container.dart';
import 'widgets/custom_genre_filter_row.dart';
import 'widgets/genre_item.dart';
import 'widgets/home_app_bar.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel model;
  final ColorsPalette colorsPalette = ColorsPalette();
  HomeView({required this.model, super.key});

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
          Expanded(
            child: customGridView(),
          ),
        ],
      ),
    ));
  }

  GridView customGridView() {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: movieGenreList
          .map((genreItem) => GenreItem(
                title: genreItem,
                onTileClicked: () {
                  widget.model.onGenreTileClicked(genreItem);
                },
              ))
          .toList(),
    );
  }
}
