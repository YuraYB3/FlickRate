import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/user/my_user.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/services/network/collection_name.dart';
import '../../app/services/network/inetwork_service.dart';
import '../../app/services/storage/directory_names.dart';

class MyUserRepository implements IMyUserRepository {
  final IStorageService _storageService;
  final INetworkService _networkService;

  MyUserRepository(
      {required INetworkService networkService,
      required IStorageService storageService})
      : _networkService = networkService,
        _storageService = storageService;

  @override
  Future<void> createUser(IMyUser user) async {
    _networkService.create(user.toJson(), collectionUsers);
  }

  @override
  Stream<IMyUser> fetchCurrentUser(String id) {
    return _networkService.fetchDataStream(collectionUsers).map((dataList) =>
        dataList
            .where((data) => data['userId'] == id)
            .map((data) => MyUser.fromJson(data))
            .first);
  }

  @override
  Future<void> changeProfilePhoto(String documentId) async {
    XFile? image = await _pickImageFromGallery();
    if (image != null) {
      String imgURL =
          await _storageService.uploadImage(directoryUserProfile, image);
      updateProfilePhoto(imgURL, documentId);
    }
  }

  Future<XFile?> _pickImageFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<void> updateProfilePhoto(String imgURl, String documentId) async {
    await _networkService
        .update({"userProfileImage": imgURl}, collectionUsers, documentId);
  }
}
