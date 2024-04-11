import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'istorage_service.dart';

class CloudStorageService implements IStorageService {
  Reference storage = FirebaseStorage.instance.ref();

  @override
  Future<String> uploadImage(
      String directoryName, XFile image, String imageName) async {
    Reference imageRef = storage.child(directoryName);
    Reference referenceImageToUpload = imageRef.child(imageName);
    await referenceImageToUpload.putFile(File(image.path));
    String imgURL = await referenceImageToUpload.getDownloadURL();
    return imgURL;
  }
  @override
  Future<void> uploadVideo(
      String directoryName, XFile video,) async {
      String videoName = "video${DateTime.now()}.mp4";
    Reference directoryRef = storage.child(directoryName);
    Reference referenceVideoToUpload = directoryRef.child(videoName);
    await referenceVideoToUpload.putFile(File(video.path));

  }

}
