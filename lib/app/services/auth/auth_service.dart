// ignore_for_file: avoid_print

import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/app/services/auth/iauth_service.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;
  String _verifyId = '';

  @override
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  AuthService({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final StreamController<AuthState> _streamController =
      StreamController.broadcast();

  @override
  Future<void> signInWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: _verifyId, smsCode: otp);
    await _firebaseAuth.signInWithCredential(cred);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sentOtp(String number) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+380$number",
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        _verifyId = verificationId;
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

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
