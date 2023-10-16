import 'package:giphy_search/models/gif_model.dart';

abstract class GiphyService {
  Future<List<GifModel>> searchGifs(
    String repositoryName, {
    int limit,
    int? offset,
  });
}
