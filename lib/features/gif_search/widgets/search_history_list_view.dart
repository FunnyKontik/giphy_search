import 'package:flutter/cupertino.dart';
import 'package:giphy_search/features/gif_search/widgets/search_history_item.dart';

class SearchHistoryListView extends StatelessWidget {
  final List<String> searchHistory;
  final ValueChanged<String> onHistoryTap;

  const SearchHistoryListView({
    required this.searchHistory,
    required this.onHistoryTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchHistory.length,
      shrinkWrap: true,
      itemBuilder: (_, index) => _buildHistoryItem(index),
    );
  }

  Widget _buildHistoryItem(int index){
    final text = searchHistory[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SearchHistoryItem(
        searchText: text,
        onTap: () => onHistoryTap(text),
      ),
    );
  }
}
