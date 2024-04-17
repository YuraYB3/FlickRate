// ignore_for_file: avoid_print

import 'dart:isolate';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flickrate/app/services/local_notification/local_notification_service.dart';
import 'package:flickrate/app/services/network/firebase_service.dart';
import 'package:flickrate/app/services/storage/cloud_storage_service.dart';
import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';
import 'package:flickrate/domain/network/inetwork_service.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

class IsolateHandler {
  Future<void> uploadFile(String filePath, String fileName,
      String directoryName, String collectionName) async {
    print('UPLOADING');
    final ReceivePort mainIsolatePort = ReceivePort();
    try {
      Map payload = {
        'filePath': filePath,
        'fileName': fileName,
        'directoryName': directoryName,
        'collectionName': collectionName
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
  try {
    mainIsolatePort.send(uploadIsolatePort.sendPort);
    uploadIsolatePort.listen(
      (message) async {
        if (message is Map) {
          await Firebase.initializeApp();
          String file = message['filePath'];
          String directoryName = message['directoryName'];
          String fileName = message['fileName'];
          String collectionName = message['collectionName'];
          ILocalNotificationService localNotification =
              LocalNotificationService();
          IStorageService storageService = CloudStorageService();
          INetworkService networkService = FirebaseService();
          final id = Random().nextInt(1000);
          storageService.uploadFile(directoryName, file, fileName).then(
            (uploadTask) async {
              uploadTask.snapshotEvents.listen((event) async {
                switch (event.state) {
                  case TaskState.running:
                    double progress =
                        100 * (event.bytesTransferred / event.totalBytes);
                    await localNotification.showNotificationWithProgress(
                        progress: progress, id: id);
                    break;
                  case TaskState.canceled:
                    print('canceled');
                    break;
                  case TaskState.error:
                    print('error');
                    break;
                  case TaskState.paused:
                    print('paused');
                    break;
                  case TaskState.success:
                    print('success');
                    break;
                  default:
                    print('default');
                    break;
                }
              });
              await uploadTask;
              String url = await uploadTask.snapshot.ref.getDownloadURL();
              await networkService
                  .create({"name": fileName, "url": url}, collectionName);
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
