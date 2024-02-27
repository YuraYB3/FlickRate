import 'package:flickrate/app/screens/home/widgets/category_item.dart';
import 'package:flutter/material.dart';

import '../../../data/category/movie_categories.dart';
//import '../../../domain/movies/imovie.dart';
import '../../theme/color_palette.dart';
import 'home_view_model.dart';

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
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: widget.colorsPalette.mainColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      "Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla Bla bla bla bla bla bla ",
                      style: TextStyle(color: Colors.white, fontSize: 24),
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
                  "Categories",
                  style: TextStyle(
                      fontSize: 20, color: widget.colorsPalette.mainColor),
                ),
                Expanded(child: Container()),
                const Text(
                  "All",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
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
              children: movieCategories
                  .map((e) => CategoryItem(
                        title: e,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
/*
StreamBuilder<List<IMovie>>(
        stream: widget.model.movieStreamList,
        builder: (context, snapshot) { 
          if (snapshot.hasError) {
            return const Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: widget.colorsPalette.mainColor,
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              "EMPTY :(",
              style: TextStyle(
                  fontSize: 24, color: widget.colorsPalette.mainColor),
            ));
          }
          final moviesData = snapshot.data!;
          return ListView.builder(
              itemBuilder: (context, index) {
                final movie = moviesData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: widget.colorsPalette.secondColor,
                      child: Text(
                        movie.name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(movie.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.genre),
                        const SizedBox(height: 4),
                        Text(
                          movie.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    onTap: () {
                      widget.model.onListTileClicked(movie);
                    },
                  ),
                );
              },
              itemCount: moviesData.length);
        },*/


