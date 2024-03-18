import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/domain/auth/iauth_service.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth;

  String _verifyId = '';
  @override
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  AuthService({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

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
  String getUserId() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  @override
  Future<void> signInWithGoogle(
      {required Function(String message) showException}) async {
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser != null) {
      try {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        showException("Error signing in with Google: $e");
      }
    } else {
      showException("User cancelled Google sign in.");
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
