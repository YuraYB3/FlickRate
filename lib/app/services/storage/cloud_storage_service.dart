// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'istorage_service.dart';

class CloudStorageService extends ChangeNotifier implements IStorageService {
  Reference storage = FirebaseStorage.instance.ref();

  @override
  Future<UploadTask> uploadFile(
      String directoryName, String file, String fileName) async {
    try {
      print("UPLOADINGGG");
      Reference fileRef = storage.child(directoryName);
      print("UPLOADINGGG 1");
      Reference referenceFileToUpload = fileRef.child(fileName);
      print("UPLOADINGGG 2");
      UploadTask uploadTask = referenceFileToUpload.putFile(File(file));
      print('GREAT');
      //  await uploadTask;
      print('GREAT 2 ');
      return uploadTask;
    } catch (e) {
      print("PROBLEM");
      Reference fileRef = storage.child(directoryName);
      print("PROBLEM 1");
      Reference referenceFileToUpload = fileRef.child(fileName);
      print("PROBLEM 2");
      UploadTask uploadTask = referenceFileToUpload.putFile(File(file));
      print('GREAT');
      //  await uploadTask;
      print('GREAT 2 ');
      print("WE HAVE A PROBLEM: $e");
      return uploadTask;
    }
  }
}
/*@override
  Future<String?> uploadFile(
      String directoryName, String filePath, String fileName) async {
    print('uploading call');
    Reference fileRef = storage.child(directoryName);
    Reference referenceFileToUpload = fileRef.child(fileName);
    print('uploading put');
    final UploadTask uploadTask =
        referenceFileToUpload.putFile(File(filePath));
    print('uploading notification');
    await _localNotificationService.showNotificationWithProgress(
        message: const RemoteMessage(
          notification: RemoteNotification(body: 'Uploading progress'),
        ),
        task: uploadTask);
    await uploadTask;
      String? downloadURL;
  try {
    downloadURL = await referenceFileToUpload.getDownloadURL();
  } catch (e) {
  
    print('Error getting download URL: $e');
  }
    return downloadURL;
  }
}*/