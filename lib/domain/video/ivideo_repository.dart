import 'package:camera/camera.dart';
import 'package:flickrate/domain/video/ivideo.dart';

abstract interface class IVideoRepository {
  Stream<List<IVideo>> fetchVideosStream();
  Future<void> uploadVideo(XFile file);
  Future<List<String>> fetchVideosURLs();
}
