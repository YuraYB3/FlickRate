import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerState { loading, readyToWork }

enum VideoState { playing, onPause }

class VideoPlayerHandler extends ChangeNotifier {
  late VideoPlayerController _videoController;

  VideoPlayerController get videoController => _videoController;

  VideoPlayerState _videoPlayerState = VideoPlayerState.loading;
  VideoPlayerState get videoPlayerState => _videoPlayerState;

  VideoState _videoState = VideoState.playing;
  VideoState get videoState => _videoState;

  Future<void> initializeVideoController(
      {required VideoPlayerController videoPlayerController}) async {
    _videoController = videoPlayerController;
    await _videoController.initialize();
    _updateVideoPlayerState(VideoPlayerState.readyToWork);
  }

  void playVideo() {
    _videoController.play();
    _videoController.setLooping(true);
    _updateVideoState(VideoState.playing);
  }

  void pauseVideo() {
    _videoController.pause();
    _updateVideoState(VideoState.onPause);
  }

  void onPlayButtonClicked() {
    switch (_videoState) {
      case VideoState.onPause:
        playVideo();
        break;
      case VideoState.playing:
        pauseVideo();
        break;
      default:
        break;
    }
  }

  void _updateVideoPlayerState(VideoPlayerState videoPlayerState) {
    _videoPlayerState = videoPlayerState;
    notifyListeners();
  }

  void _updateVideoState(VideoState videoState) {
    _videoState = videoState;
    notifyListeners();
  }
}
