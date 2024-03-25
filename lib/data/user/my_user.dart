import 'package:flickrate/domain/user/i_my_user.dart';

class MyUser implements IMyUser {
  @override
  String documentId;

  @override
  final String userId;
  @override
  final String userName;
  @override
  String userProfileImage;
  @override
  int userLikes;
  @override
  int reviewCount;

  MyUser(
      {this.userProfileImage = '',
      this.documentId = '',
      this.reviewCount = 0,
      this.userLikes = 0,
      required this.userId,
      required this.userName});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        userName: json['userName'],
        userLikes: json['userLikes'],
        reviewCount: json['reviewCount'],
        documentId: json['documentId'],
        userId: json['userId'],
        userProfileImage: json['userProfileImage']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userProfileImage': userProfileImage,
      'userName': userName
    };
  }
}
