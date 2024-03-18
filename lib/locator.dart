import 'package:flickrate/app/services/local_storage/local_storage.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flickrate/domain/notification/inotification_service.dart';
import 'package:flickrate/app/services/notification/notification_service.dart';
import 'package:flickrate/app/services/storage/istorage_service.dart';
import 'package:flickrate/data/user/my_user_repository.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/permission_handler.dart';
import 'package:get_it/get_it.dart';

import 'app/services/functions/function_service.dart';
import 'domain/functions/ifunction_service.dart';
import 'app/services/network/firebase_service.dart';
import 'domain/network/inetwork_service.dart';
import 'app/services/storage/cloud_storage_service.dart';
import 'data/movies/movie_repository.dart';
import 'domain/movies/imovie_repository.dart';

final locator = GetIt.instance;

void initFunctionService() {
  locator.registerFactory<IFunctionService>(
    () => FunctionService(),
  );
}

void initPermissionHandler() {
  locator.registerSingleton<PermissionHandler>(PermissionHandler());
}

void initNetworkService() {
  locator.registerFactory<INetworkService>(
    () => FirebaseService(),
  );
}

void initStorageService() {
  locator.registerFactory<IStorageService>(
    () => CloudStorageService(),
  );
}

void initNotificationService() {
  locator.registerSingleton<INotificationService>(
    NotificationService(),
  );
}

void initLocalStorage() {
  locator.registerSingleton<ILocalStorage>(
    LocalStorage(),
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
        localStorage: locator.get<ILocalStorage>()),
  );
}
