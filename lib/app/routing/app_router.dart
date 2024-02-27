import 'package:flickrate/app/screens/create_movie/create_movie_factory.dart';
import 'package:flickrate/app/screens/movie_details/movie_factory.dart';
import 'package:flickrate/domain/movies/imovie.dart';
import 'package:flutter/material.dart';

import '../screens/home/home_factory.dart';
import '../screens/login/login_factory.dart';
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
            builder: (_) => _buildAddMovieSettings(routeSettings));
      case routeMovie:
        final movie = routeSettings.arguments as IMovie;
        return MaterialPageRoute(
            builder: (_) => _buildMovieSettings(routeSettings, movie));
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

  Widget _buildAddMovieSettings(RouteSettings settings) {
    return CreateMovieFactory.build();
  }

  Widget _buildMovieSettings(RouteSettings settings, IMovie movie) {
    return MovieFactory.build(movie);
  }
}
