// ignore_for_file: avoid_print

import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/locator.dart';
import 'package:uni_links/uni_links.dart';

class UniService {
  Future<void> init() async {
    try {
      final Uri? uri = await getInitialUri();
      _uniHandler(uri);
    } catch (e) {
      print('Error initializing deep link: $e');
    }
    uriLinkStream.listen((Uri? uri) async {
      _uniHandler(uri);
    }, onError: (error) {
      print('Error listening to URI links: $error');
    });
  }
}

//@pragma("vm:entry-point")
Future<void> _uniHandler(Uri? uri) async {
  if (uri == null || uri.queryParameters.isEmpty) return;

  try {
    final Map<String, String> params = uri.queryParameters;
    String receivedMovieId = '';
    receivedMovieId = params['movieId'] ?? '';
    print('Received movie ID: $receivedMovieId');

    final INavigationUtil navigatorUtil = locator<INavigationUtil>();
    if (receivedMovieId.isNotEmpty) {
      print('Navigate to movie page');
      await navigatorUtil.navigateTo(routeMovie, data: receivedMovieId);
    } else {
      print('Navigate to user reviews');
      await navigatorUtil.navigateTo(routeShowReviews);
    }
  } catch (e) {
    print('Exception handling deep link: $e');
  }
}
