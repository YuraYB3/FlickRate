import 'package:video_player/video_player.dart';

abstract interface class IVideoPlayerControllersService {
  VideoPlayerController getController(String videoURL);
  void clearController({required VideoPlayerController controller});
  void disposeControllers();
}
