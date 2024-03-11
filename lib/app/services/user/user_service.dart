// ignore_for_file: avoid_print

import 'dart:async';

import '../auth/iauth_service.dart';
import 'iuser_service.dart';

enum UserState { readyToWork, notAuthorized }

class UserService implements IUserService {
  final IAuthService _authService;
  final StreamController<UserState> _userStateStreamController =
      StreamController();

  UserService({required IAuthService authService}) : _authService = authService;

  @override
  void logOut() async {
    await _authService.signOut();
  }

  @override
  void signWithGoogle() {
    _authService.signInWithGoogle();
  }

  @override
  Future<void> signWithOtp(String otp) async {
    await _authService.signInWithOtp(otp: otp);
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
  Future sentOtp(String number) async {
    await _authService.sentOtp(number);
  }

  @override
  Future<void> register(String email, String password) async {
    await _authService.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  @override
  String getCurrentUserId() {
    print('Getting current user ID');
    String userId = _authService.getUserId();
    print('Current user ID: $userId');
    return userId;
  }
}
