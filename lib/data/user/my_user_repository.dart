import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/user/my_user.dart';
import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/services/network/collection_name.dart';
import '../../domain/network/inetwork_service.dart';
import '../../app/services/storage/directory_names.dart';

class MyUserRepository implements IMyUserRepository {
  final IStorageService _storageService;
  final INetworkService _networkService;

  MyUserRepository({
    required INetworkService networkService,
    required IStorageService storageService,
  })  : _networkService = networkService,
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
  Future<void> changeProfilePhoto(
      String documentId, String imageName, XFile image) async {
    await _storageService
        .uploadFile(directoryUserProfile, image.path, imageName)
        .then(
      (value) async {
        await value;
        String url = await value.snapshot.ref.getDownloadURL();
        await updateProfileImage(url, documentId);
      },
    );
  }

  @override
  Future<XFile?> pickImageFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<void> updateProfileImage(String imgURl, String documentId) async {
    await _networkService
        .update({"userProfileImage": imgURl}, collectionUsers, documentId);
  }

  @override
  Future<void> updateUserNickName(String nickName, String documentId) async {
    await _networkService
        .update({"userName": nickName}, collectionUsers, documentId);
  }
}
