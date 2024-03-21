import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/app/services/auth/auth_service.dart';
import 'package:flickrate/app/services/user/iuser_service.dart';
import 'package:flickrate/app/services/user/user_service.dart';
import 'package:flickrate/domain/notification/inotification_service.dart';
import 'package:flickrate/app/services/notification/notification_service.dart';
import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/user/my_user_repository.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:get_it/get_it.dart';

import 'app/services/functions/function_service.dart';
import 'domain/auth/iauth_service.dart';
import 'domain/functions/ifunction_service.dart';
import 'app/services/network/firebase_service.dart';
import 'domain/network/inetwork_service.dart';
import 'app/services/storage/cloud_storage_service.dart';
import 'data/movies/movie_repository.dart';
import 'domain/movies/imovie_repository.dart';

final locator = GetIt.instance;

void initFunctionService() {
  locator.registerSingleton<IFunctionService>(
    FunctionService(),
  );
}

void initPermissionHandler() {
  locator.registerSingleton<PermissionHandler>(PermissionHandler());
}

void initNetworkService() {
  locator.registerSingleton<INetworkService>(
    FirebaseService(),
  );
}

void initStorageService() {
  locator.registerSingleton<IStorageService>(
    CloudStorageService(),
  );
}

void initAuthService() {
  locator.registerSingleton<IAuthService>(
    AuthService(firebaseAuth: FirebaseAuth.instance),
  );
}

void initUserService() {
  locator.registerSingleton<IUserService>(
    UserService(authService: locator<IAuthService>()),
  );
}

void initNotificationService() {
  locator.registerSingleton<INotificationService>(
    NotificationService(),
  );
}

void initRepos() {
  locator.registerFactory<IMovieRepository>(
    () => MovieRepository(
        networkService: locator.get<INetworkService>(),
        functionService: locator.get<IFunctionService>()),
  );

  locator.registerFactory<IMyUserRepository>(
    () => MyUserRepository(
      networkService: locator.get<INetworkService>(),
      storageService: locator.get<IStorageService>(),
    ),
  );
}
