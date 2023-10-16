import 'package:giphy_search/models/image_model.dart';

class Images {
  final ImageModel fixedWidth;

  Images({
    required this.fixedWidth,
  });

  Map<String, dynamic> toJson() {
    return {
      'fixed_width': fixedWidth.toJson(),
    };
  }

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      fixedWidth:
          ImageModel.fromJson(json['fixed_width'] as Map<String, dynamic>),
    );
  }
}
