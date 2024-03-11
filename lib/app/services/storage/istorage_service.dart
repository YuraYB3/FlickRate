import 'package:image_picker/image_picker.dart';

abstract interface class IStorageService {
  Future<String> uploadImage(String directoryName, XFile image);
}
