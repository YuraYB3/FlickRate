import 'package:flickrate/app/screens/add_movie/add_movie_factory.dart';
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
      case routeAddMovie:
        return MaterialPageRoute(
            builder: (_) => _buildAddMovieSettings(routeSettings));

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
    return AddMovieFactory.build();
  }
}
