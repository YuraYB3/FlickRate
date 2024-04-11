import 'package:image_picker/image_picker.dart';

abstract interface class IStorageService {
  Future<String> uploadFile(
      String directoryName, XFile image, String imageName);
 
}
