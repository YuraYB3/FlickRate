import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import '../../../domain/storage/istorage_service.dart';

class CloudStorageService extends ChangeNotifier implements IStorageService {
  Reference storage = FirebaseStorage.instance.ref();

  @override
  Future<UploadTask> uploadFile(
      String directoryName, String file, String fileName) async {
    Reference fileRef = storage.child(directoryName);
    Reference referenceFileToUpload = fileRef.child(fileName);
    UploadTask uploadTask = referenceFileToUpload.putFile(File(file));

    return uploadTask;
  }
}
