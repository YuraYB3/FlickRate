import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IAuthService {
  Future sentOtp();
  Future loginWithOtp({required String otp});
  Future logOut();
  FirebaseAuth get firebaseAuth;
}
