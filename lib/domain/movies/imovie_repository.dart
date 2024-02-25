import 'package:flickrate/domain/movies/imovie.dart';

abstract interface class IMovieRepository {
  Future<void> createMovie(IMovie movie);
  Stream<List<IMovie>> fetchMoviesStream();
}
