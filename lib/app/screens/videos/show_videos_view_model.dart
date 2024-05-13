// ignore_for_file: avoid_print
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flutter/material.dart';

class ShowVideosViewModel extends ChangeNotifier {
  final IVideoRepository _videoRepository;

  late Stream<List<IVideo>> _videoStreamList;
  Stream<List<IVideo>> get videoStreamList => _videoStreamList;

  late List<String> videosURLs;

  bool isURLsLoaded = false;

  ShowVideosViewModel({
    required IVideoRepository videoRepository,
  }) : _videoRepository = videoRepository {
    _getVideosURLs();
  }

  Future<void> _getVideosURLs() async {
    _videoStreamList = _videoRepository.fetchVideosStream();
    isURLsLoaded = true;
    notifyListeners();
  }
}
