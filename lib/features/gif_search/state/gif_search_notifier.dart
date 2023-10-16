import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:giphy_search/features/gif_search/services/giphy_service.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GifLocalKeys {
  favorite,
  history,
}

class GifSearchNotifier extends ChangeNotifier {
  final GiphyService _giphyService;
  late final SharedPreferences _sharedPreferences;

  bool _isInitialized = false;

  bool _isLoading = false;

  final List<GifModel> _gifs = [];

  final List<GifModel> _favoriteGifs = [];

  final List<String> _gifsSearchHistory = [];

  bool get isInitialized => _isInitialized;

  bool get isLoading => _isLoading;

  List<GifModel> get gifs => List.unmodifiable(_gifs);

  List<GifModel> get favoriteGifs => List.unmodifiable(_favoriteGifs);

  List<String> get gifsSearchHistory => List.unmodifiable(_gifsSearchHistory);

  GifSearchNotifier(this._giphyService) {
    _initialize();
  }

  Future<void> _initialize() async {
    // Added for demonstration of the SplashScreen, since initialization
    // of the app takes too little time
    await Future<void>.delayed(const Duration(seconds: 3));

    _sharedPreferences = await SharedPreferences.getInstance();


    await _loadLocalData(
      GifLocalKeys.favorite.name,
      _favoriteGifs,
      GifModel.fromJson,
    );

    await _loadLocalData(
      GifLocalKeys.history.name,
      _gifsSearchHistory,
    );

    _isInitialized = true;

    notifyListeners();
  }

  Future<void> _saveDataToLocal<T>(
    String key,
    List<T> data, [
    Map<String, dynamic> Function(T)? toJson,
  ]) async {
    final jsonStringList =
        data.map((e) => jsonEncode(toJson == null ? e : toJson(e))).toList();

    await _sharedPreferences.setStringList(key, jsonStringList);
  }

  Future<void> _loadLocalData<T>(
    String key,
    List<T> targetList, [
    T Function(Map<String, dynamic>)? fromJson,
  ]) async {
    final jsonList = _sharedPreferences.getStringList(key);

    if (jsonList != null) {
      targetList.addAll(
        jsonList.map(
          (e) => fromJson != null
              ? fromJson(jsonDecode(e) as Map<String, dynamic>)
              : jsonDecode(e) as T,
        ),
      );
    }
  }

  void toggleFavoriteGif(
    GifModel gifModel, {
    required bool isFavorite,
  }) {
    if (isFavorite && !_favoriteGifs.contains(gifModel)) {
      _favoriteGifs.add(gifModel);

      _saveDataToLocal(
        GifLocalKeys.favorite.name,
        _favoriteGifs,
        (model) => model.toJson(),
      );
    } else if (!isFavorite && _favoriteGifs.contains(gifModel)) {
      _favoriteGifs.remove(gifModel);

      _saveDataToLocal(
        GifLocalKeys.favorite.name,
        _favoriteGifs,
        (model) => model.toJson(),
      );
    }

    notifyListeners();
  }

  bool isGifFavorite(GifModel gifModel) {
    return _favoriteGifs.contains(gifModel);
  }

  Future<void> loadMoreGifs(
    String gifName,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      _gifs.addAll(
        await _giphyService.searchGifs(
          gifName,
          offset: _gifs.length,
        ),
      );

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> searchGifs(
    String searchText,
  ) async {
    try {
      _isLoading = true;
      _gifs.clear();
      notifyListeners();

      _gifs.addAll(
        await _giphyService.searchGifs(
          searchText,
        ),
      );

      if (_gifs.isNotEmpty) {
        _updateSearchHistory(searchText);
      }

      unawaited(
        _saveDataToLocal(
          GifLocalKeys.history.name,
          _gifsSearchHistory,
        ),
      );

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;

      notifyListeners();
    }
  }

  void _updateSearchHistory(String searchText) {
    _gifsSearchHistory.insert(0, searchText);
  }

  void clearGifs() {
    _gifs.clear();

    notifyListeners();
  }
}
