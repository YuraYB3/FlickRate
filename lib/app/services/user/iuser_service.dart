import 'user_service.dart';

abstract interface class IUserService {
  Future<void> signWithOtp(String otp);
  void signWithGoogle();
  void logOut();
  Stream<UserState> userStateStream();
  Future sentOtp(String number);
}
