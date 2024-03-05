import 'package:flickrate/app/services/network/firebase_service.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flickrate/data/movies/movie_repository.dart';
import 'package:flickrate/domain/movies/imovie_repository.dart';
import 'package:get_it/get_it.dart';

import 'app/services/functions/function_service.dart';
import 'app/services/functions/ifunction_service.dart';

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
}
