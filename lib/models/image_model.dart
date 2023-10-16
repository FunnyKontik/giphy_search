class ImageModel {
  final String url;
  final double height;

  ImageModel({required this.url, required this.height});

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'height': height.toString(),
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'] as String,
      height: double.parse(json['height'] as String),
    );
  }
}
