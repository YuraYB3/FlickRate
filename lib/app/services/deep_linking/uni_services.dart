// ignore_for_file: avoid_print

import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:uni_links/uni_links.dart';

class UniService {
  final INavigationUtil _navigationUtil;

  UniService({required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil;

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

  Future<void> _uniHandler(Uri? uri) async {
    if (uri == null || uri.queryParameters.isEmpty) return;

    try {
      final Map<String, String> params = uri.queryParameters;
      String receivedMovieId = '';
      receivedMovieId = params['movieId'] ?? '';
      print('Received movie ID: $receivedMovieId');

      if (receivedMovieId.isNotEmpty) {
        print('Navigate to movie page');
        await _navigationUtil.navigateTo(routeMovie, data: receivedMovieId);
      } else {
        print('Navigate to default page');
        //   await _navigationUtil.navigateTo(routeDefaultURLPage);
      }
    } catch (e) {
      print('Exception handling deep link: $e');
      //  await _navigationUtil.navigateTo(routeDefaultURLPage);
    }
  }
}
