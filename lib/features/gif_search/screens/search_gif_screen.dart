import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giphy_search/constants/navigation.dart';
import 'package:giphy_search/features/gif_search/state/gif_search_notifier.dart';
import 'package:giphy_search/features/gif_search/widgets/empty_result_message.dart';
import 'package:giphy_search/features/gif_search/widgets/gifs_grid_view.dart';
import 'package:giphy_search/features/gif_search/widgets/search_header.dart';
import 'package:giphy_search/features/gif_search/widgets/search_history_list_view.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:giphy_search/utils/debounce_util.dart';
import 'package:giphy_search/widgets/app_bar/appbar_blue_button.dart';
import 'package:giphy_search/widgets/app_bar/custom_appbar.dart';
import 'package:giphy_search/widgets/custom_activity_indicator.dart';
import 'package:giphy_search/widgets/giphy_search_scaffold.dart';
import 'package:giphy_search/widgets/search_textfield.dart';
import 'package:giphy_search/widgets/svg_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchGifScreen extends StatefulWidget {
  const SearchGifScreen({super.key});

  @override
  State<SearchGifScreen> createState() => _SearchGifScreenState();
}

class _SearchGifScreenState extends State<SearchGifScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DebounceUtil _debounce =
      DebounceUtil(debounceTime: const Duration(seconds: 1));
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_scrollControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((GifSearchNotifier notifier) => notifier.isLoading);

    final gifs = context.select((GifSearchNotifier notifier) => notifier.gifs);

    final searchHistory = context
        .select((GifSearchNotifier notifier) => notifier.gifsSearchHistory);

    return GiphySearchScaffold(
      appBar: CustomAppBar(
        appbarTitle: 'Giphy Search',
        actions: [
          AppbarBlueButton(
            icon: const SvgIcon(
              size: 18,
              asset: 'assets/icons/star.svg',
            ),
            onTap: () => _onStarTap(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            onChanged: (value) => _onChanged(context, value),
            onClearInput: () => _onClearInput(context),
          ),
          if (!isLoading || gifs.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildHeader(gifs),
            ),
            _buildEmptyResultMessage(searchHistory, gifs),
          ],
          if (isLoading && gifs.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CustomActivityIndicator(),
            ),
          if (_searchController.text.isEmpty)
            Expanded(
              child: SearchHistoryListView(
                searchHistory: searchHistory,
                onHistoryTap: _onHistoryTap,
              ),
            )
          else
            Expanded(
              child: GifsGridView(
                gifs: gifs,
                controller: _scrollController,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(List<GifModel> foundGifs) {
    final text = foundGifs.isEmpty && _searchController.text.isNotEmpty
        ? 'What we found'
        : foundGifs.isEmpty && _searchController.text.isEmpty
            ? 'Search History'
            : 'What we have found';

    return Align(
      alignment: Alignment.centerLeft,
      child: SearchHeader(text: text),
    );
  }

  Widget _buildEmptyResultMessage(
    List<String> searchHistory,
    List<GifModel> foundGifs,
  ) {
    if (searchHistory.isEmpty && _searchController.text.isEmpty) {
      return const EmptyResultMessage(
        message: [
          'You have empty history.',
          'Click on search to start journey!',
        ],
      );
    }

    if (_searchController.text.isNotEmpty && foundGifs.isEmpty) {
      return const EmptyResultMessage(
        message: [
          'Nothing was find for your search.',
          'Please check the spelling',
        ],
      );
    }

    return const SizedBox();
  }

  void _scrollControllerListener() {
    const paginationStartThreshold = 350;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent -
                paginationStartThreshold &&
        !context.read<GifSearchNotifier>().isLoading) {
      _loadMoreGifs(context, _searchController.text);
    }
  }

  void _onStarTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutes.favoriteGifs.routeName);
  }

  void _onClearInput(BuildContext context) {
    _debounce.cancel();

    setState(() {
      context.read<GifSearchNotifier>().clearGifs();
    });
  }

  void _loadMoreGifs(
    BuildContext context,
    String name,
  ) {
    context.read<GifSearchNotifier>().loadMoreGifs(name);
  }

  void _onChanged(BuildContext context, String value) {
    if (value.isEmpty) {
      _onClearInput(context);
    } else {
      _searchGifs(context, value);
    }
  }

  void _searchGifs(BuildContext context, String name) {
    _debounce.run(() {
      context.read<GifSearchNotifier>().searchGifs(name);
    });
  }

  void _onHistoryTap(String searchText) {
    _searchController.text = searchText;
    context.read<GifSearchNotifier>().searchGifs(searchText);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollControllerListener);
    super.dispose();
  }
}
