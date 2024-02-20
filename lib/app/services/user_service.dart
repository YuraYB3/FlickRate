import '../../domain/auth/iauth_service.dart';
import '../../domain/local_storage/ilocal_storage.dart';
import 'iuser_service.dart';
import 'local_storage/keys.dart';

class UserService implements IUserService {
  final IAuthService _authService;
  final ILocalStorage _localStorage;

  UserService(
      {required IAuthService authService, required ILocalStorage localStorage})
      : _authService = authService,
        _localStorage = localStorage;

  @override
  void logout() async {
    await _authService.logOut();
    _localStorage.delete(keyPhone);
  }
}
