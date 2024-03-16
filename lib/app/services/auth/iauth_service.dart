import 'package:firebase_auth/firebase_auth.dart';

enum AuthState { unauthorized, authorized }

abstract interface class IAuthService {
  Stream<AuthState> authState();
  String getUserId();
  FirebaseAuth get firebaseAuth;
  bool isUserLoggedIn();
  Future<void> sentOtp(String number);
  Future<void> signInWithOtp({required String otp});
  Future<void> signOut();
  Future<void> signInWithGoogle(
      {required Function(String message) showException});
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
}
