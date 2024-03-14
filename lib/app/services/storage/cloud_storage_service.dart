import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'istorage_service.dart';

class CloudStorageService implements IStorageService {
  Reference storage = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadImage(String directoryName, XFile image) async {
    Reference imageRef = storage.child(directoryName);
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    uniqueFileName += image.name;
    Reference referenceImageToUpload = imageRef.child(uniqueFileName);
    await referenceImageToUpload.putFile(File(image.path));
    String imgURL = await referenceImageToUpload.getDownloadURL();
    return imgURL;
  }
}
