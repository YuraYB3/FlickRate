import 'package:flutter/material.dart';

import '../screens/create_movie/create_movie_factory.dart';
import '../screens/home/home_factory.dart';
import '../screens/login/login_factory.dart';
import '../screens/movie_details/movie_factory.dart';
import '../screens/show_all_movies/show_all_movies_factory.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeLogin:
        return MaterialPageRoute(
            builder: (_) => _buildShowAllMoviesSettings(routeSettings));
      case routeHome:
        return MaterialPageRoute(
            builder: (_) => _buildHomeSettings(routeSettings));
      case routeCreateMovie:
        return MaterialPageRoute(
            builder: (_) => _buildAddMovieSettings(routeSettings));
      case routeMovie:
        final movieId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _buildMovieSettings(routeSettings, movieId));
      case routeShowAllMovies:
        return MaterialPageRoute(
            builder: (_) => _buildLoginSettings(routeSettings));
      default:
    }
    return null;
  }

  Widget _buildShowAllMoviesSettings(RouteSettings settings) {
    return LoginFactory.build();
  }

  Widget _buildHomeSettings(RouteSettings settings) {
    return HomeFactory.build();
  }

  Widget _buildAddMovieSettings(RouteSettings settings) {
    return CreateMovieFactory.build();
  }

  Widget _buildMovieSettings(RouteSettings settings, String movieId) {
    return MovieFactory.build(movieId);
  }

  Widget _buildLoginSettings(RouteSettings settings) {
    return ShowAllMoviesFactory.build();
  }
}
