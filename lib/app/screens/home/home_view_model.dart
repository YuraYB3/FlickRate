import 'package:flickrate/data/movie.dart';
import 'package:flutter/material.dart';

import '../../services/iuser_service.dart';

class HomeViewModel extends ChangeNotifier {
  final IUserService _userService;
  final MovieModel _movieModel = MovieModel();
  late Stream<List<Movie>> _movieList;

  Stream<List<Movie>> get movieList => _movieList;

  HomeViewModel({required IUserService userService})
      : _userService = userService {
    getItems();
  }

  void onLogOutButtonPressed(BuildContext context) async {
    _userService.logout();
  }

  Future<void> getItems() async {
    _movieList = _movieModel.getMovies();
    notifyListeners();
  }
}
