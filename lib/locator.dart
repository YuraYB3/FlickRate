import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/app/services/date_time/date_time_service.dart';
import 'package:flickrate/app/services/language/language_service.dart';
import 'package:flickrate/domain/date_time/idate_time_service.dart';
import 'package:flickrate/domain/language/ilanguage_service.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flickrate/domain/navigation/inavigation_util.dart';
import 'package:flickrate/app/routing/navigation_util.dart';
import 'package:flickrate/app/services/auth/auth_service.dart';
import 'package:flickrate/app/services/camera/camera_config.dart';
import 'package:flickrate/app/services/camera/camera_core.dart';
import 'package:flickrate/app/services/camera/camera_service.dart';
import 'package:flickrate/domain/camera/icamera_config.dart';
import 'package:flickrate/domain/camera/icamera_core.dart';
import 'package:flickrate/domain/camera/icamera_service.dart';
import 'package:flickrate/app/services/local_notification/local_notification_service.dart';
import 'package:flickrate/app/services/deep_linking/uni_services.dart';
import 'package:flickrate/domain/user_service/iuser_service.dart';
import 'package:flickrate/app/services/user/user_service.dart';
import 'package:flickrate/data/review/review_repository.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';
import 'package:flickrate/domain/notification/inotification_service.dart';
import 'package:flickrate/app/services/notification/notification_service.dart';
import 'package:flickrate/domain/storage/istorage_service.dart';
import 'package:flickrate/data/user/my_user_repository.dart';
import 'package:flickrate/domain/review/ireview_repository.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:flickrate/utils/isolate_handler.dart';
import 'package:flickrate/app/services/local_storage/local_storage.dart';
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

void init() {
  initFunctionService();
  initPermissionHandler();
  initNetworkService();
  initNavigationService();
  initLocalNotificationService();
  initNotificationService();
  initStorageService();
  initDeepLinkService();
  initAuthService();
  initUserService();
  initCameraCore();
  initCameraConfig();
  initCameraService();
  initIsolateHandler();
  initLocalStorage();
  initLanguageService();
  initDateTimeService();
  initRepos();
}

void initIsolateHandler() {
  locator.registerFactory<IsolateHandler>(
    () => IsolateHandler(),
  );
}

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

void initNavigationService() {
  locator.registerSingleton<INavigationUtil>(
    NavigationUtil(),
  );
}

void initLocalNotificationService() {
  locator.registerSingleton<ILocalNotificationService>(
    LocalNotificationService(),
  );
}

void initNotificationService() {
  locator.registerSingleton<INotificationService>(
    NotificationService(
        localNotificationService: locator<ILocalNotificationService>()),
  );
}

void initStorageService() {
  locator.registerSingleton<IStorageService>(
    CloudStorageService(),
  );
}

void initDeepLinkService() {
  locator.registerSingleton<UniService>(
      UniService(navigationUtil: locator<INavigationUtil>()));
}

void initCameraCore() {
  locator.registerSingleton<ICameraCore>(CameraCore());
}

void initCameraConfig() {
  locator.registerSingleton<ICameraConfig>(
      CameraConfig(cameraResolutionPreset: cameraResolutionPreset));
}

void initCameraService() {
  locator.registerFactory<ICameraService>(
    () => CameraService(
      cameraConfig: locator.get<ICameraConfig>(),
      cameraCore: locator.get<ICameraCore>(),
    ),
  );
}

void initLocalStorage() {
  locator.registerSingleton<ILocalStorage>(
    LocalStorage(),
  );
}

void initLanguageService() {
  locator.registerSingleton<ILanguageService>(
    LanguageService(
      localStorage: locator.get<ILocalStorage>(),
    ),
  );
}

void initDateTimeService() {
  locator.registerLazySingleton<IDateTimeService>(
    () => DateTimeService(),
  );
}

void initRepos() {
  locator.registerSingleton<IMovieRepository>(
    MovieRepository(
      networkService: locator.get<INetworkService>(),
    ),
  );
  locator.registerFactory<IMyUserRepository>(
    () => MyUserRepository(
      networkService: locator.get<INetworkService>(),
      storageService: locator.get<IStorageService>(),
    ),
  );

  locator.registerFactory<IReviewRepository>(
    () => ReviewRepository(networkService: locator.get<INetworkService>()),
  );
}
