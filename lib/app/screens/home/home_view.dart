import 'package:flutter/material.dart';

import '../../../data/movie.dart';
import '../../theme/color_palete.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel model;
  final ColorsPalete colorsPalete;
  const HomeView({required this.colorsPalete, required this.model, super.key});

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
        backgroundColor: widget.colorsPalete.mainColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              widget.model.onLogOutButtonPressed(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Movie>>(
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
                color: widget.colorsPalete.mainColor,
              ),
            );
          }
          final moviesData = snapshot.data!;
          return ListView.builder(
              itemBuilder: (context, index) {
                final movie = moviesData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: widget.colorsPalete.secondColor,
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
                    onTap: () {},
                  ),
                );
              },
              itemCount: moviesData.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: widget.colorsPalete.mainColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
