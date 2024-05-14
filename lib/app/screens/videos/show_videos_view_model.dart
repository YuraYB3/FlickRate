// ignore_for_file: avoid_print
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flickrate/domain/video_player_controllers_service/ivideo_player_controllers__service.dart';
import 'package:flutter/material.dart';

class ShowVideosViewModel extends ChangeNotifier {
  final IVideoRepository _videoRepository;
  final IVideoPlayerControllersService _controllersService;
  IVideoPlayerControllersService get controllersService => _controllersService;

  int _currentVideoIndex = 0;
  int get currentVideoIndex => _currentVideoIndex;

  late Stream<List<IVideo>> _videoStreamList;
  Stream<List<IVideo>> get videoStreamList => _videoStreamList;

  ShowVideosViewModel({
    required IVideoRepository videoRepository,
    required IVideoPlayerControllersService controllersService,
  })  : _videoRepository = videoRepository,
        _controllersService = controllersService;

  Future<void> getVideosURLs() async {
    _videoStreamList = _videoRepository.fetchVideosStream();
  }

  void updateCurrentVideoIndex(int value) {
    _currentVideoIndex = value;
    notifyListeners();
  }
}
