import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:giphy_search/constants/navigation.dart';
import 'package:giphy_search/features/gif_search/widgets/gif_item.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:go_router/go_router.dart';

class GifsGridView extends StatelessWidget {
  final List<GifModel> gifs;
  final ScrollController? controller;

  const GifsGridView({
    required this.gifs,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const spacing = 5.0;

    return MasonryGridView.builder(
      shrinkWrap: true,
      controller: controller,
      itemCount: gifs.length,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _buildGifItem(context, gifs[index]);
      },
    );
  }

  Widget _buildGifItem(
    BuildContext context,
    GifModel gifModel,
  ) {
    return GestureDetector(
      onTap: () => _onGifTap(context, gifModel),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GifItem(imageModel: gifModel.images.fixedWidth),
      ),
    );
  }

  void _onGifTap(BuildContext context, GifModel gifModel) {
    GoRouter.of(context).push(AppRoutes.gifDetails.routeName, extra: gifModel);
  }
}
