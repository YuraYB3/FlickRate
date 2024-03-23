import 'package:flutter/material.dart';

import '../screens/create_review/create_review_factory.dart';
import '../screens/home/home_factory.dart';
import '../screens/login/login_factory.dart';
import '../screens/movies/movie_details/movie_factory.dart';
import '../screens/movies/show_movies/show_movies_factory.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeLogin:
        return MaterialPageRoute(
            builder: (_) => _buildLoginSettings(routeSettings));
      case routeHome:
        return MaterialPageRoute(
            builder: (_) => _buildHomeSettings(routeSettings));
      case routeCreateMovie:
        return MaterialPageRoute(
            builder: (_) => _buildCreateReviewSettings(routeSettings));
      case routeMovie:
        final movieId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _buildMovieSettings(routeSettings, movieId));
      case routeShowMovies:
        final genre = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _buildShowMoviesSettings(routeSettings, genre));
      default:
    }
    return null;
  }

  Widget _buildLoginSettings(RouteSettings settings) {
    return LoginFactory.build();
  }

  Widget _buildHomeSettings(RouteSettings settings) {
    return HomeFactory.build();
  }

  Widget _buildCreateReviewSettings(RouteSettings settings) {
    return CreateReviewFactory.build();
  }

  Widget _buildMovieSettings(RouteSettings settings, String movieId) {
    return MovieFactory.build(movieId);
  }

  Widget _buildShowMoviesSettings(RouteSettings settings, String genre) {
    return ShowMoviesFactory.build(genre);
  }
}
