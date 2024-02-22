import '../../domain/auth/iauth_service.dart';
import 'iuser_service.dart';

class UserService implements IUserService {
  final IAuthService _authService;

  UserService({required IAuthService authService}) : _authService = authService;

  @override
  void logout() async {
    await _authService.logOut();
  }

  @override
  void loginWithGoogle() {
    _authService.signInWithGoogle();
  }

  @override
  Future<void> loginWithOtp(String otp) async {
    await _authService.signinWithOtp(otp: otp);
  }
}
