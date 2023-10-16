import 'package:flutter/material.dart';
import 'package:giphy_search/features/gif_search/state/gif_search_notifier.dart';
import 'package:giphy_search/features/gif_search/widgets/empty_result_message.dart';
import 'package:giphy_search/features/gif_search/widgets/gifs_grid_view.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:giphy_search/widgets/app_bar/appbar_blue_button.dart';
import 'package:giphy_search/widgets/app_bar/custom_appbar.dart';
import 'package:giphy_search/widgets/giphy_search_scaffold.dart';
import 'package:giphy_search/widgets/svg_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class FavoriteGifsScreen extends StatelessWidget {
  const FavoriteGifsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repositories = context.select(
      (GifSearchNotifier notifier) => notifier.favoriteGifs,
    );

    return GiphySearchScaffold(
      appBar: CustomAppBar(
        appbarTitle: 'Favorite GIFs list',
        leading: AppbarBlueButton(
          icon: const SvgIcon(
            asset: 'assets/icons/left.svg',
            size: 18,
          ),
          onTap: () => _onBackButtonTap(context),
        ),
      ),
      body: _buildBody(context, repositories),
    );
  }

  Widget _buildBody(BuildContext context, List<GifModel> repositories) {
    if (repositories.isEmpty) {
      return const Align(
        alignment: Alignment.topCenter,
        child: EmptyResultMessage(
          message: [
            'You have no favorites.',
            'Click on star while searching to add first favorite',
          ],
        ),
      );
    }
    else {
      return GifsGridView(gifs: repositories);
    }
  }

  void _onBackButtonTap(BuildContext context) {
    GoRouter.of(context).pop();
  }
}
