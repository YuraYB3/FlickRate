import '../ibase_model.dart';

abstract interface class IMyUser implements IBaseModel {
  final String userProfileImage;
  final String userId;
  IMyUser(this.userId, this.userProfileImage);
}
