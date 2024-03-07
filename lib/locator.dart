import 'package:flickrate/data/user/my_user_repository.dart';
import 'package:flickrate/domain/user/i_my_user_repository.dart';
import 'package:get_it/get_it.dart';

import 'app/services/functions/function_service.dart';
import 'app/services/functions/ifunction_service.dart';
import 'app/services/network/firebase_service.dart';
import 'app/services/network/inetwork_service.dart';
import 'data/movies/movie_repository.dart';
import 'domain/movies/imovie_repository.dart';

final locator = GetIt.instance;

void initFunctionService() {
  locator.registerFactory<IFunctionService>(
    () => FunctionService(),
  );
}

void initNetworkService() {
  locator.registerFactory<INetworkService>(
    () => FirebaseService(),
  );
}

void initRepos() {
  locator.registerFactory<IMovieRepository>(
    () => MovieRepository(
        networkService: locator.get<INetworkService>(),
        functionService: locator.get<IFunctionService>()),
  );

  locator.registerFactory<IMyUserRepository>(
    () => MyUserRepository(networkService: locator.get<INetworkService>()),
  );
}
