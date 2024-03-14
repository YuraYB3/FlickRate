import '../ibase_model.dart';

abstract interface class IMovie implements IBaseModel {
  final String name;
  final String userId;
  final String genre;
  final num rating;
  final String description;

  IMovie(
      {required this.userId,
      required this.rating,
      required this.name,
      required this.genre,
      required this.description});
}
