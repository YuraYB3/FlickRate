import 'package:firebase_auth/firebase_auth.dart';

enum AuthState { unauthorized, authorized }

abstract interface class IAuthService {
  Stream<AuthState> authState();
  Future<String?> getUserId();
  FirebaseAuth get firebaseAuth;
  bool isUserLoggedIn();
  Future<void> sentOtp(String number);
  Future<void> signInWithOtp({required String otp});
  Future<void> signOut();
  Future<void> signInWithGoogle();
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
}
