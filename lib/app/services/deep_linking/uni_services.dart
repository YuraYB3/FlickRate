import 'dart:developer';

import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:uni_links/uni_links.dart';

class UniService {
  final INavigationUtil _navigationUtil;

  UniService({required INavigationUtil navigationUtil})
      : _navigationUtil = navigationUtil;

  Future<void> getInitialLink() async {
    try {
      final Uri? uri = await getInitialUri();
      _handleUri(uri);
    } catch (e) {
      log('Error initializing deep link: $e');
    }
    uriLinkStream.listen((Uri? uri) async {
      _handleUri(uri);
    }, onError: (error) {
      log('Error listening to URI links: $error');
    });
  }

  Future<void> _handleUri(Uri? uri) async {
    if (uri == null || uri.queryParameters.isEmpty) return;

    try {
      final Map<String, String> params = uri.queryParameters;
      String receivedMovieId = '';
      receivedMovieId = params['movieId'] ?? '';
      log('Received movie ID: $receivedMovieId');

      if (receivedMovieId.isNotEmpty) {
        log('Navigate to movie page');
        await _navigationUtil.navigateTo(routeMovie, data: receivedMovieId);
      } else {
        log('Navigate to default page');
        //   await _navigationUtil.navigateTo(routeDefaultURLPage);
      }
    } catch (e) {
      log('Exception handling deep link: $e');
      //  await _navigationUtil.navigateTo(routeDefaultURLPage);
    }
  }
}
