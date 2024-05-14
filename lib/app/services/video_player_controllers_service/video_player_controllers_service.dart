import 'dart:developer';
import 'package:video_player/video_player.dart';
import '../../../domain/video_player_controllers_service/ivideo_player_controllers__service.dart';

class VideoPlayerControllersService implements IVideoPlayerControllersService {
  List<VideoPlayerController> _videoControllers = [];

  final int _maxQuantityOfControllers = 4;

  VideoPlayerControllersService() {
    _generateDefaultURLForControllers();
  }

  void _generateDefaultURLForControllers() {
    log('INIT CONTROLLERS');
    _videoControllers = List.generate(
      _maxQuantityOfControllers,
      (index) => VideoPlayerController.networkUrl(
        Uri.parse(''),
      ),
    );
  }

  @override
  VideoPlayerController getController(String videoURL) {
    log("GET");
    int emptyIndex = _checkIndex(
      _videoControllers.indexWhere(
        (element) => element.dataSource.isEmpty,
      ),
    );
    log("$emptyIndex GET");
    _videoControllers[emptyIndex] = _prepareVideoController(videoURL);
    _replaceControllerInVideoControllersList(
        emptyIndex, _videoControllers[emptyIndex]);
    return _videoControllers[emptyIndex];
  }

  @override
  void clearController({required VideoPlayerController controller}) {
    log('CLEAR CONTROLLER');
    int index = _checkIndex(
        _videoControllers.indexWhere((element) => element == controller));
    log('CLEAR $index');
    _replaceControllerInVideoControllersList(
      index,
      _prepareVideoController(''),
    );
    controller.dispose();
  }

  @override
  void disposeControllers() {
    log('DISPOSE');
    for (var element in _videoControllers) {
      element.dispose();
    }
  }

  void _replaceControllerInVideoControllersList(
      int index, VideoPlayerController controller) {
    _videoControllers[index] = controller;
  }

  int _checkIndex(int index) => index == -1 ? 0 : index;

  VideoPlayerController _prepareVideoController(String videoURL) {
    return VideoPlayerController.networkUrl(Uri.parse(videoURL));
  }
}
