import 'package:flickrate/domain/movies/imovie.dart';

abstract interface class IMovieRepository {
  Future<void> createMovie(IMovie movie);
  Future<void> updateMovie(IMovie movie);
  Future<void> deleteMovie(IMovie movie);
  Stream<List<IMovie>> fetchMoviesStream();
  Stream<IMovie> fetchMovie(String id);
}
