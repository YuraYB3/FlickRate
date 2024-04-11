import 'package:flickrate/domain/video/ivideo.dart';

class Video implements IVideo {
  @override
  String documentId;

  @override
  String name;

  @override
  String url;

  Video({required this.documentId, required this.name, required this.url});

  @override
  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'name': name,
      'url': url,
    };
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      documentId: json['documentId'],
      name: json['name'],
      url: json['url'],
    );
  }
}
