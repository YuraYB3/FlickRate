import 'package:firebase_auth/firebase_auth.dart';

enum AuthState { unauthorized, authorized }

abstract interface class IAuthService {
  Stream<AuthState> authState();
  FirebaseAuth get firebaseAuth;
  bool isUserLoggedIn();
  Future sentOtp(String number);
  Future signinWithOtp({required String otp});
  Future logOut();
  Future signInWithGoogle();
}
