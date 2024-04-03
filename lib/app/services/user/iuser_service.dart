import 'user_service.dart';

abstract interface class IUserService {
  Future<void> signWithOtp(String otp);
  Future<void> signWithGoogle(
      {required Function(String message) showException});
  void logOut();
  void closeUserStreamController();
  Stream<UserState> userStateStream();
  Future<void> sentOtp(String number);
  Future<void> register({required String email, required String password});
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
  String getCurrentUserId();
}
