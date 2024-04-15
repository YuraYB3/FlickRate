import 'package:firebase_storage/firebase_storage.dart';

abstract interface class IStorageService {
  Future<UploadTask> uploadFile(
      String directoryName, String filePath, String fileName);
}
