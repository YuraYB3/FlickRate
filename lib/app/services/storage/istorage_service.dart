import 'package:image_picker/image_picker.dart';

abstract interface class IStorageService {
  Future<String> uploadImage(
      String directoryName, XFile image, String imageName);
  Future<void> uploadVideo(
    String directoryName,
    XFile video,
  );
}
