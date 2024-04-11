// ignore_for_file: avoid_print
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flutter/material.dart';

class ShowVideosViewModel extends ChangeNotifier {
  
  final IVideoRepository _videoRepository;

  late List<String> videosURLs;

  bool isURLsLoaded = false;

  ShowVideosViewModel({required IVideoRepository videoRepository})
      : _videoRepository = videoRepository {
    getVideosURLs();
  }


  Future<void> getVideosURLs() async {
    videosURLs = await _videoRepository.fetchVideosURLs();
    isURLsLoaded = true;
    notifyListeners();
  }
}
