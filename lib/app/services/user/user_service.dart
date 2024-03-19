import 'dart:async';

import '../../../domain/auth/iauth_service.dart';
import 'iuser_service.dart';

enum UserState { readyToWork, notAuthorized }

class UserService implements IUserService {
  final IAuthService _authService;
  final StreamController<UserState> _userStateStreamController =
      StreamController();

  UserService({
    required IAuthService authService,
  }) : _authService = authService;

  @override
  void logOut() async {
    await _authService.signOut();
  }

  @override
  Future<void> register(
      {required String email, required String password}) async {
    await _authService
        .signUpWithEmailAndPassword(email: email, password: password)
        .then((value) => Future.delayed(const Duration(seconds: 10)));
  }

  @override
  Future<void> signWithGoogle(
      {required Function(String message) showException}) async {
    await _authService.signInWithGoogle(showException: showException);
  }

  @override
  Future sentOtp(String number) async {
    await _authService.sentOtp(number);
  }

  @override
  Future<void> signWithOtp(String otp) async {
    await _authService.signInWithOtp(otp: otp);
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _authService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Stream<UserState> userStateStream() {
    Stream<UserState> userStream = _authService.authState().map((event) {
      switch (event) {
        case AuthState.authorized:
          return UserState.readyToWork;
        case AuthState.unauthorized:
          return UserState.notAuthorized;
      }
    });
    userStream.listen((event) {
      _userStateStreamController.add(event);
    });
    return _userStateStreamController.stream;
  }

  @override
  String getCurrentUserId() {
    String userId = _authService.getUserId();
    return userId;
  }
}
