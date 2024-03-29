import 'imovie.dart';

abstract interface class IMovieRepository {
  // Future<void> createMovie(IMovie movie);
//  Future<void> updateMovie(IMovie movie);
//  Future<void> deleteMovie(String id);
  Stream<List<IMovie>> fetchMoviesStream();
  Stream<IMovie> fetchMovie(String id);
  Stream<List<IMovie>> fetchMoviesStreamByGenre(String genre);
  Stream<List<IMovie>> fetchMoviesByName(String movieName);
  // void increaseRating(String id);
  // void decreaseRating(String id);
}
