import 'imovie.dart';

abstract interface class IMovieRepository {
  Stream<List<IMovie>> fetchMoviesStream();
  Stream<List<IMovie>> fetchMoviesByName(String movieName);
  Future<IMovie> getMovieById(String id);
  Stream<IMovie> getDailyMovie();
}
