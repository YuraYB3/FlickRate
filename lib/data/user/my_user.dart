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

  MyUser(
      {this.userProfileImage = '',
      this.documentId = '',
      required this.userId,
      required this.userName});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        userName: json['userName'],
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
