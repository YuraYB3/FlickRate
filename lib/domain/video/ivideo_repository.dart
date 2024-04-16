import 'package:flickrate/domain/video/ivideo.dart';

abstract interface class IVideoRepository {
  Stream<List<IVideo>> fetchVideosStream();
  Future<void> uploadVideo(String filePath);
  Future<List<String>> fetchVideosURLs();
}
