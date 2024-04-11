import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'istorage_service.dart';

class CloudStorageService implements IStorageService {
  Reference storage = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadFile(
      String directoryName, XFile file, String fileName) async {
    Reference fileRef = storage.child(directoryName);
    Reference referenceFileToUpload = fileRef.child(fileName);
    await referenceFileToUpload.putFile(File(file.path));
    String fileURL = await referenceFileToUpload.getDownloadURL();
    return fileURL;
  }

}
