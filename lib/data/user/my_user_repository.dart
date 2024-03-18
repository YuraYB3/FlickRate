import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/user/my_user.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/services/local_storage/keys.dart';
import '../../app/services/network/collection_name.dart';
import '../../domain/network/inetwork_service.dart';
import '../../app/services/storage/directory_names.dart';

class MyUserRepository implements IMyUserRepository {
  final IStorageService _storageService;
  final INetworkService _networkService;
  final ILocalStorage _localStorage;

  MyUserRepository(
      {required INetworkService networkService,
      required IStorageService storageService,
      required ILocalStorage localStorage})
      : _networkService = networkService,
        _storageService = storageService,
        _localStorage = localStorage;

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
  Future<void> changeProfilePhoto(String documentId, String imageName) async {
    XFile? image = await _pickImageFromGallery();
    if (image != null) {
      String imgURL = await _storageService.uploadImage(
          directoryUserProfile, image, imageName);
      updateProfileImage(imgURL, documentId);
    }
  }

  Future<XFile?> _pickImageFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<void> updateProfileImage(String imgURl, String documentId) async {
    await _networkService
        .update({"userProfileImage": imgURl}, collectionUsers, documentId);
    _localStorage.save(keyProfileImage, imgURl);
  }

  @override
  Future<void> saveUserToLocalStorage(String id) async {
    var t = fetchCurrentUser(id);
    IMyUser user = await t.first;
    _saveInfo(user);
  }

  void _saveInfo(IMyUser user) {
    _localStorage.save(keyProfileImage, user.userProfileImage);
    _localStorage.save(keyProfileName, user.userName);
    _localStorage.save(keyUserID, user.userId);
    _localStorage.save(keyProfileDocumentID, user.documentId);
  }

  @override
  Future<void> deleteInfoFromLocalStorage() async {
    await _localStorage.deleteAll();
  }
}
