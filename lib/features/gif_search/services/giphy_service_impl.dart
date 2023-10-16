import 'package:giphy_search/features/gif_search/services/giphy_dio_wrapper.dart';
import 'package:giphy_search/features/gif_search/services/giphy_service.dart';

import 'package:giphy_search/models/gif_model.dart';

class GiphyServiceImpl implements GiphyService {
  final _giphyDioWrapper = GiphyDioWrapper();

  @override
  Future<List<GifModel>> searchGifs(
    String gifName, {
    int? offset,
    int limit = 15,
  }) async {
    final response = await _giphyDioWrapper.get<Map<String, dynamic>>(
      '/v1/gifs/search',
      queryParameters: {
        'q': gifName,
        'limit': limit,
        'offset': offset,
      },
    );

    final results = response?.data;
    final items = results?['data'] as List<dynamic>;

    return items
        .map((item) => GifModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
