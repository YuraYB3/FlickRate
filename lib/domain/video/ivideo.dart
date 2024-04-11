import '../ibase_model.dart';

abstract interface class IVideo implements IBaseModel {
  final String name;
  final String url;

  IVideo(
      {required this.name,
      required this.url,
     });
}
