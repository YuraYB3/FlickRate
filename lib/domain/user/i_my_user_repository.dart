import 'package:flickrate/domain/user/i_my_user.dart';

abstract interface class IMyUserRepository {
  Future<void> createUser(IMyUser user);
  Stream<IMyUser> fetchCurrentUser(String id);
  Future<void> changeProfilePhoto(String documentId, String imageName);
  Future<void> saveUserToLocalStorage(String id);
  Future<void> deleteInfoFromLocalStorage();
}
