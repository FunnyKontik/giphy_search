import 'package:flutter/material.dart';
import 'package:giphy_search/constants/app_text_styles.dart';
import 'package:giphy_search/features/gif_search/state/gif_search_notifier.dart';
import 'package:giphy_search/features/gif_search/widgets/gif_item.dart';
import 'package:giphy_search/features/gif_search/widgets/star_switch.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:giphy_search/utils/debounce_util.dart';
import 'package:giphy_search/widgets/app_bar/appbar_blue_button.dart';
import 'package:giphy_search/widgets/app_bar/custom_appbar.dart';
import 'package:giphy_search/widgets/giphy_search_scaffold.dart';
import 'package:giphy_search/widgets/svg_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GifDetailsScreen extends StatefulWidget {
  final GifModel model;

  const GifDetailsScreen({required this.model, super.key});

  @override
  State<GifDetailsScreen> createState() => _GifDetailsScreenState();
}

class _GifDetailsScreenState extends State<GifDetailsScreen> {
  final _debounce =
      DebounceUtil(debounceTime: const Duration(milliseconds: 1000));

  bool? _isGifFavorite;

  @override
  Widget build(BuildContext context) {
    final isGifFavorite = context.select(
        (GifSearchNotifier notifier) => notifier.isGifFavorite(widget.model));

    return GiphySearchScaffold(
      appBar: CustomAppBar(
        appbarTitle: 'GIF details',
        leading: AppbarBlueButton(
          icon: const SvgIcon(
            asset: 'assets/icons/left.svg',
            size: 18,
          ),
          onTap: () => _onBackButtonTap(context),
        ),
      ),
      body: _buildBody(context, isGifFavorite),
    );
  }

  Widget _buildBody(BuildContext context, bool isGifFavorite) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GifItem(imageModel: widget.model.images.fixedWidth),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.model.title,
                  style: AppTextStyles.bodyTextStyle,
                ),
              ),
              StarSwitch(
                value: isGifFavorite,
                onChanged: (value) => _onFavoriteChanged(
                  context,
                  widget.model,
                  isFavorite: value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onBackButtonTap(BuildContext context) {
    if(_debounce.isRunning){
      context
          .read<GifSearchNotifier>()
          .toggleFavoriteGif(widget.model, isFavorite: _isGifFavorite!);
    }

    GoRouter.of(context).pop();
  }

  void _onFavoriteChanged(
    BuildContext context,
    GifModel repositoryModel, {
    required bool isFavorite,
  }) {
    _isGifFavorite = isFavorite;

    _debounce.run(() {
      if (mounted) {
        context
            .read<GifSearchNotifier>()
            .toggleFavoriteGif(repositoryModel, isFavorite: isFavorite);
      }
    });
  }
}
