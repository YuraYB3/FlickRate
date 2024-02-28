import 'package:flickrate/domain/ibase_model.dart';

abstract interface class IMovie implements IBaseModel {
  final String name;
  final String genre;
  final double rating;
  final String description;

  IMovie(
      {required this.rating,
      required this.name,
      required this.genre,
      required this.description});
}
