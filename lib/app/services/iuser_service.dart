import 'user_service.dart';

abstract interface class IUserService {
  Future<void> loginWithOtp(String otp);
  void loginWithGoogle();
  void logout();
  Stream<UserState> userStateStream();
}
