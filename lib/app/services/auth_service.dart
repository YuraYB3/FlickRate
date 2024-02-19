import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/app/services/iauth_service.dart';

import '../routing/inavigation_util.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;
  String verifyId = '';

  @override
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  AuthService(
      {required INavigationUtil navigationUtil,
      required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final StreamController<AuthState> _streamController =
      StreamController.broadcast();
  @override
  Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    await _firebaseAuth.signInWithCredential(cred);
  }

  @override
  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future sentOtp() async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+380969699999",
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    );
  }

  @override
  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Stream<AuthState> authState() {
    Stream<AuthState> stream =
        _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        return AuthState.authorized;
      } else {
        return AuthState.unauthorized;
      }
    });
    stream.listen((authState) {
      _streamController.add(authState);
    });
    return _streamController.stream;
  }
}
