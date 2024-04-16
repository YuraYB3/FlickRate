// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flickrate/app/services/local_notification/local_notification_service.dart';
import 'package:flickrate/app/services/network/firebase_service.dart';
import 'package:flickrate/app/services/storage/cloud_storage_service.dart';
import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/video/video.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';
import 'package:flickrate/domain/video/ivideo.dart';
import 'package:flickrate/domain/video/ivideo_repository.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

import '../../app/services/network/collection_name.dart';
import '../../app/services/storage/directory_names.dart';
import '../../domain/network/inetwork_service.dart';

class VideoRepository implements IVideoRepository {
  final INetworkService _networkService;

  VideoRepository({
    required INetworkService networkService,
  }) : _networkService = networkService;

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
    print('UPLOADING');
    final ReceivePort mainIsolatePort = ReceivePort();
    try {
      Map payload = {
        'filePath':filePath
      };
      final FlutterIsolate uploadIsolate = await FlutterIsolate.spawn(
          _uploadToStorage, mainIsolatePort.sendPort);
      mainIsolatePort.listen((message) {
        if (message is SendPort) {
          print("COMMUNICATION SETUP SUCCESS");
          message.send(payload);
          print("SENT INPUT PAYLOAD TO UPLOAD ISOLATE");
        }
        if (message is String) {
          print("GOT THE UPLOAD RESULT FROM UPLOAD ISOLATE:$message");
          uploadIsolate.kill();
          mainIsolatePort.close();
        }
      });
    } catch (e) {
      mainIsolatePort.close();
    } finally {
      print('WE HERE');
    }
  }
}

_uploadToStorage(SendPort mainIsolatePort) {
  final uploadIsolatePort = ReceivePort();
  String name = "video${DateTime.now().toString()}.mp4";
  try {
    mainIsolatePort.send(uploadIsolatePort.sendPort);
    uploadIsolatePort.listen(
      (message) async {
        if (message is Map) {
          await Firebase.initializeApp();
          String file = message['filePath'];
          ILocalNotificationService localNotification =
              LocalNotificationService();
          IStorageService storageService = CloudStorageService();
          INetworkService networkService = FirebaseService();
          storageService.uploadFile(directoryVideos, file, name).then(
            (uploadTask) async {
              await localNotification.showNotificationWithProgress(
                  message: const RemoteMessage(
                    notification: RemoteNotification(
                        body: 'Uploading progress', title: 'Video uploading'),
                  ),
                  task: uploadTask);
              await uploadTask;
              String url = await uploadTask.snapshot.ref.getDownloadURL();
              await networkService
                  .create({"name": name, "url": url}, collectionVideos);
              print('NOT EMPTY');
              print(url);
              uploadIsolatePort.close();
              mainIsolatePort.send(url);
            },
          );
        }
      },
    );
  } catch (e) {
    print(e.toString());
    mainIsolatePort.send('error');
  }
}
