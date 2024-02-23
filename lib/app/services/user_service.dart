import 'dart:async';

import '../../domain/auth/iauth_service.dart';
import 'iuser_service.dart';

enum UserState { readyToWork, notAuthorized }

class UserService implements IUserService {
  final IAuthService _authService;
  final StreamController<UserState> _userStateStreamController =
      StreamController.broadcast();

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
    Stream<UserState> stream = _authService.authState().map((event) {
      switch (event) {
        case AuthState.authorized:
          return UserState.readyToWork;
        case AuthState.unauthorized:
          return UserState.notAuthorized;
      }
    });
    stream.listen((event) {
      _userStateStreamController.add(event);
    });
    return _userStateStreamController.stream;
  }
}
