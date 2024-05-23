import 'package:flickrate/app/screens/camera/camera_factory.dart';
import 'package:flickrate/app/screens/camera/camera_view_model.dart';
import 'package:flickrate/app/screens/reviews/show_reviews_factory.dart';
import 'package:flickrate/app/screens/reviews/show_reviews_view_model.dart';
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
        return MaterialPageRoute(
            builder: (_) => _buildLoginSettings(routeSettings));
      case routeHome:
        return MaterialPageRoute(
            builder: (_) => _buildHomeSettings(routeSettings));
      case routeMovie:
        return MaterialPageRoute(
            builder: (_) => _buildMovieSettings(routeSettings));
      case routeShowMovies:
        return MaterialPageRoute(
            builder: (_) => _buildShowMoviesSettings(routeSettings));
      case routeShowReviews:
        return MaterialPageRoute(
            builder: (_) => _buildShowReviewsSetting(routeSettings));
      case routeCamera:
        return MaterialPageRoute(
            builder: (_) => _buildCameraSettings(routeSettings));
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }

  Widget _buildLoginSettings(RouteSettings settings) {
    return LoginFactory.build();
  }

  Widget _buildHomeSettings(RouteSettings settings) {
    return HomeFactory.build();
  }

  Widget _buildMovieSettings(RouteSettings settings) {
    final String movieId = settings.arguments as String;
    return MovieFactory.build(movieId);
  }

  Widget _buildShowMoviesSettings(RouteSettings settings) {
    final genre = settings.arguments as String;
    return ShowMoviesFactory.build(genre);
  }

  Widget _buildShowReviewsSetting(RouteSettings settings) {
    final Map<String, dynamic> argsMap =
        settings.arguments as Map<String, dynamic>;
    final ReviewLoadingType reviewLoadingType =
        argsMap['loadingType'] ?? ReviewLoadingType.byUserId;
    final String movieGenre = argsMap['movieGenre'] ?? '';
    return ShowReviewsFactory.build(
        reviewLoadingType: reviewLoadingType, genre: movieGenre);
  }

  Widget _buildCameraSettings(RouteSettings settings) {
    final Map<String, dynamic> argsMap =
        settings.arguments as Map<String, dynamic>;
    final String imageName = argsMap['imageName'] ?? '';
    final String documentId = argsMap['documentId'] ?? '';
    final CameraTask cameraTask = argsMap['cameraTask'] ?? CameraTask.test;
    return CameraFactory.build(
        imageName: imageName, documentId: documentId, cameraTask: cameraTask);
  }
}
