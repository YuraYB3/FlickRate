import 'package:flutter/material.dart';

import '../../../data/genre/movie_genre.dart';
import '../../theme/color_palette.dart';
import 'home_view_model.dart';
import 'widgets/genre_item.dart';

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
          Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hi",
                  style: TextStyle(
                      fontSize: 24, color: widget.colorsPalette.mainColor),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: widget.colorsPalette.mainColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: screenHeight * 0.3,
              width: screenWidth,
              decoration: BoxDecoration(
                  color: widget.colorsPalette.mainColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      "Have you watched new movie? ",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                                onPressed: widget.model.onAddButtonClicked,
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: widget.colorsPalette.mainColor),
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Genres",
                  style: TextStyle(
                      fontSize: 20, color: widget.colorsPalette.mainColor),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    widget.model.onShowAllClicked();
                  },
                  child: const Text(
                    "All",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: movieGenreList
                  .map((genreItem) => GenreItem(
                        title: genreItem,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
