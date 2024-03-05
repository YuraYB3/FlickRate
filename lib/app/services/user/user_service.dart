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
    await _authService.logOut();
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
}
