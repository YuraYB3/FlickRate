import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class IMyUserRepository {
  Future<void> createUser(IMyUser user);
  Stream<IMyUser> fetchCurrentUser(String id);
  Future<void> changeProfilePhoto(
      String documentId, String imageName, String imagePath);
  Future<void> updateUserNickName(String nickName, String documentId);
  Future<XFile?> pickImageFromGallery();
}
