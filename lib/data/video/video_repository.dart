import 'package:camera/camera.dart';
import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/video/video.dart';
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';

import '../../app/services/network/collection_name.dart';
import '../../app/services/storage/directory_names.dart';
import '../../domain/network/inetwork_service.dart';

class VideoRepository implements IVideoRepository {
  final INetworkService _networkService;
  final IStorageService _storageService;

  VideoRepository(
      {required INetworkService networkService,
      required IStorageService storageService})
      : _networkService = networkService,
        _storageService = storageService;

  @override
  Stream<List<IVideo>> fetchVideosStream() {
    return _networkService.fetchDataStream(collectionVideos).map(
          (dataList) => dataList.map((data) => Video.fromJson(data)).toList(),
        );
  }
  @override
  Future<List<String>> fetchVideosURLs() async {
    final Stream<List<Map<String, dynamic>>> dataStream =
        _networkService.fetchDataStream(collectionVideos);
    final List<Map<String, dynamic>> dataList = await dataStream.first;
    final List<String> videoUrls =
        dataList.map((data) => Video.fromJson(data).url).toList();
    return videoUrls;
  }

  @override
  Future<void> uploadVideo(XFile file) async {
    String name = "video${DateTime.now().toString()}.mp4";
    String url = await _storageService.uploadFile(directoryVideos, file, name);
    _addOnFirestore(url, name);
  }

  void _addOnFirestore(String url, String name) {
    _networkService.create({"name": name, "url": url}, collectionVideos);
  }
}
