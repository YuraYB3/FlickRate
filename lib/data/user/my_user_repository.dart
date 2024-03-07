import 'package:flickrate/domain/user/i_my_user.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';

import '../../app/services/network/collection_name.dart';
import '../../app/services/network/inetwork_service.dart';

class MyUserRepository implements IMyUserRepository {
  final INetworkService _networkService;

  MyUserRepository({required INetworkService networkService})
      : _networkService = networkService;

  @override
  Future<void> createUser(IMyUser user) async {
    _networkService.create(user.toJson(), collectionUsers);
  }
}
