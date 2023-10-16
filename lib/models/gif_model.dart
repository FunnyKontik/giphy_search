import 'package:flutter/cupertino.dart';
import 'package:giphy_search/models/images.dart';

@immutable
class GifModel {
  final String id;
  final String title;
  final Images images;

  const GifModel({
    required this.id,
    required this.images,
    this.title = '',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GifModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          images == other.images;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ images.hashCode;

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'images': images.toJson()};
  }

  factory GifModel.fromJson(Map<String, dynamic> json) {
    return GifModel(
      id: json['id'] as String,
      title: json['title'] as String,
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
    );
  }
}
