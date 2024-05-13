import 'dart:async';
import 'dart:io';
import 'package:flickrate/app/services/storage/directory_names.dart';
import 'package:flickrate/domain/storage/istorage_service.dart';
import 'package:flickrate/data/video/video.dart';
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flickrate/utils/isolate_handler.dart';

import '../../app/services/network/collection_name.dart';
import '../../domain/network/inetwork_service.dart';

class VideoRepository implements IVideoRepository {
  final INetworkService _networkService;
  final IsolateHandler _isolateHandler;
  final IStorageService _storageService;

  VideoRepository(
      {required INetworkService networkService,
      required IsolateHandler isolateHandler,
      required IStorageService storageService})
      : _networkService = networkService,
        _storageService = storageService,
        _isolateHandler = isolateHandler;

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
  Future<void> uploadVideo(String filePath) async {
    String fileName = "video${DateTime.now().toString()}.mp4";
    switch (Platform.operatingSystem) {
      case 'ios':
        _storageService.uploadFile(directoryVideos, filePath, fileName).then(
          (uploadTask) async {
            await uploadTask;
            String url = await uploadTask.snapshot.ref.getDownloadURL();
            await _networkService
                .create({"name": fileName, "url": url}, collectionVideos);
          },
        );
        break;
      default:
        await _isolateHandler.uploadFile(
            filePath, fileName, directoryVideos, collectionVideos);
        break;
    }
  }
}
