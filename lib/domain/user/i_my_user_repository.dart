import 'package:flickrate/domain/user/i_my_user.dart';

abstract interface class IMyUserRepository {
  Future<void> createUser(IMyUser user);
}
