import 'package:dio/dio.dart';

class GiphyDioWrapper {
  // TODO(Anatoly): move api key to the safe place.
  // Api key hardcoded only for demonstration of the app. We should
  // never hardcode API keys in our production source code.
  static const String _apiKey = 'HtUS2z92LUkxOT7oM517PXn8HSfrD7zX';

  final Dio _dio;

  GiphyDioWrapper()
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://api.giphy.com',
          queryParameters: {'api_key': _apiKey},
        ));

  Future<Response<T>?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } catch (e) {
      print(e);
    }

    return null;
  }
}
