abstract interface class IBaseModel {
  String id;

  IBaseModel({required this.id});

  Map<String, dynamic> toJson();
}
