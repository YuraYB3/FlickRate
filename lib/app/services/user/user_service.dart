import 'dart:async';

import 'package:flickrate/domain/user/i_my_user_repository.dart';

import '../../../domain/auth/iauth_service.dart';
import 'iuser_service.dart';

enum UserState { readyToWork, notAuthorized }

class UserService implements IUserService {
  final IAuthService _authService;
  final IMyUserRepository _myUserRepository;
  final StreamController<UserState> _userStateStreamController =
      StreamController();

  UserService({
    required IAuthService authService,
    required IMyUserRepository userRepository,
  })  : _authService = authService,
        _myUserRepository = userRepository;

  @override
  void logOut() async {
    await _authService.signOut();
    await _myUserRepository.deleteInfoFromLocalStorage();
  }

  @override
  Future<void> register(
      {required String email, required String password}) async {
    await _authService
        .signUpWithEmailAndPassword(email: email, password: password)
        .then((value) =>
            _myUserRepository.saveUserToLocalStorage(getCurrentUserId()));
  }

  @override
  Future<void> signWithGoogle(
      {required Function(String message) showException}) async {
    await _authService.signInWithGoogle(showException: showException).then(
        (value) =>
            _myUserRepository.saveUserToLocalStorage(getCurrentUserId()));
  }

  @override
  Future sentOtp(String number) async {
    await _authService.sentOtp(number);
  }

  @override
  Future<void> signWithOtp(String otp) async {
    await _authService.signInWithOtp(otp: otp).then((value) =>
        _myUserRepository.saveUserToLocalStorage(getCurrentUserId()));
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _authService
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) =>
            _myUserRepository.saveUserToLocalStorage(getCurrentUserId()));
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
