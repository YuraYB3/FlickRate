import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/app/services/iauth_service.dart';

import '../routing/inavigation_util.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;
  final INavigationUtil _navigationUtil;
  String verifyId = '';

  @override
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  AuthService(
      {required INavigationUtil navigationUtil,
      required FirebaseAuth firebaseAuth})
      : _navigationUtil = navigationUtil,
        _firebaseAuth = firebaseAuth;

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
        _navigationUtil.navigateTo(routeEnterOtp);
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    );
  }
}
