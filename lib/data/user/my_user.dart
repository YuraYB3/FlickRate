import 'package:flickrate/domain/user/i_my_user.dart';

class MyUser implements IMyUser {
  @override
  String documentId;

  @override
  final String userId;
  @override
  String userProfileImage;

  MyUser(
      {this.userProfileImage = '', this.documentId = '', required this.userId});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        documentId: json['documentId'],
        userId: json['userId'],
        userProfileImage: json['userProfileImage']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userProfileImage': userProfileImage};
  }
}
