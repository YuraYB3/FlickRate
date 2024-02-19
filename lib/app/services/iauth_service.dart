import 'package:firebase_auth/firebase_auth.dart';

enum AuthState { unauthorized, authorized }

abstract interface class IAuthService {
  Stream<AuthState> authState();
  Future sentOtp();
  Future loginWithOtp({required String otp});
  Future logOut();
  FirebaseAuth get firebaseAuth;
  bool isUserLoggedIn();
}
