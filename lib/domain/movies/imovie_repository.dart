import 'imovie.dart';

abstract interface class IMovieRepository {
  Stream<List<IMovie>> fetchAllMoviesStream();
  Stream<List<IMovie>> fetchMoviesByName(String movieName);
  Future<IMovie> getMovieById(String id);
  Stream<IMovie> getDailyMovie();
}
