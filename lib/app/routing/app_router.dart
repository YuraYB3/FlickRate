import 'package:flickrate/app/screens/reviews/show_reviews/show_reviews_factory.dart';
import 'package:flutter/material.dart';

import '../screens/home/home_factory.dart';
import '../screens/login/login_factory.dart';
import '../screens/movies/movie_details/movie_factory.dart';
import '../screens/movies/show_movies/show_movies_factory.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeLogin:
        return MaterialPageRoute(builder: (_) => _buildLoginSettings());
      case routeHome:
        return MaterialPageRoute(builder: (_) => _buildHomeSettings());
      case routeMovie:
        final movieId = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => _buildMovieSettings(movieId));
      case routeShowMovies:
        final genre = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _buildShowMoviesSettings(genre));
      case routeShowReviews:
        return MaterialPageRoute(builder: (_) => _buildShowReviewsSetting());
      default:
    }
    return null;
  }

  Widget _buildLoginSettings() {
    return LoginFactory.build();
  }

  Widget _buildHomeSettings() {
    return HomeFactory.build();
  }

  Widget _buildMovieSettings(String movieId) {
    return MovieFactory.build(movieId);
  }

  Widget _buildShowMoviesSettings(String genre) {
    return ShowMoviesFactory.build(genre);
  }

  Widget _buildShowReviewsSetting() {
    return ShowReviewsFactory.build();
  }
}
