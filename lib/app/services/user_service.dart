import 'package:flickrate/app/services/local_storage/keys.dart';
import 'package:flickrate/domain/auth/iauth_service.dart';
import 'package:flickrate/app/services/iuser_service.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';

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
