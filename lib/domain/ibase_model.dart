abstract interface class IBaseModel {
  String documentId;

  IBaseModel({required this.documentId});

  Map<String, dynamic> toJson();
}
