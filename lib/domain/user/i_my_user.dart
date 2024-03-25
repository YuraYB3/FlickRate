import '../ibase_model.dart';

abstract interface class IMyUser implements IBaseModel {
  final String userProfileImage;
  final String userName;
  final String userId;
  final int userLikes;
  final int reviewCount;
  IMyUser(this.userId, this.userProfileImage, this.userName, this.reviewCount,
      this.userLikes);
}
