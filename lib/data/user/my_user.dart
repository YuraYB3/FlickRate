import 'package:flickrate/domain/user/i_my_user.dart';

class MyUser implements IMyUser {
  @override
  String documentId;
  @override
  final String email;
  @override
  final String userId;

  MyUser({this.documentId = '', required this.email, required this.userId});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      documentId: json['documentId'],
      email: json['email'],
      userId: json['userId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userId': userId,
    };
  }
}
