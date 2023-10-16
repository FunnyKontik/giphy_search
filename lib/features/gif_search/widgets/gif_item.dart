import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:giphy_search/models/image_model.dart';
import 'package:giphy_search/widgets/custom_activity_indicator.dart';

class GifItem extends StatelessWidget {
  final ImageModel imageModel;

  const GifItem({required this.imageModel, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageModel.height,
      child: Image.network(
        imageModel.url,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
            ? child
            : const ColoredBox(
                color: AppColors.layerColor,
                child: CustomActivityIndicator(),
              ),
      ),
    );
  }
}
