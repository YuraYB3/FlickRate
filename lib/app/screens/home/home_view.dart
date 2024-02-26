import 'package:flutter/material.dart';

import '../../../domain/movies/imovie.dart';
import '../../theme/color_palette.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel model;
  final ColorsPalette colorsPalette;
  const HomeView({required this.colorsPalette, required this.model, super.key});

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
      appBar: AppBar(
        backgroundColor: widget.colorsPalette.mainColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              widget.model.onLogOutButtonPressed(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<IMovie>>(
        stream: widget.model.movieList,
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
                      print('clicked');
                    },
                  ),
                );
              },
              itemCount: moviesData.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.model.onFloatingButtonClicked,
        backgroundColor: widget.colorsPalette.mainColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
