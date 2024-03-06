import 'user_service.dart';

abstract interface class IUserService {
  Future<void> signWithOtp(String otp);
  void signWithGoogle();
  void logOut();
  Stream<UserState> userStateStream();
  Future<void> sentOtp(String number);
  Future<void> register(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
}
