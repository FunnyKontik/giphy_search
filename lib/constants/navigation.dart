import 'package:giphy_search/features/gif_search/screens/favorite_gifs_screen.dart';
import 'package:giphy_search/features/gif_search/screens/gif_details_screen.dart';
import 'package:giphy_search/features/gif_search/screens/search_gif_screen.dart';
import 'package:giphy_search/features/splash/splash_screen.dart';
import 'package:giphy_search/models/gif_model.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  splash,
  gifSearch,
  favoriteGifs,
  gifDetails;

  String get routeName {
    switch (this) {
      case AppRoutes.splash:
        return '/splash';
      case AppRoutes.gifSearch:
        return '/gifSearch';
      case AppRoutes.favoriteGifs:
        return '/favoriteGifs';
      case AppRoutes.gifDetails:
        return '/gifDetails';
    }
  }
}

class Navigation {
  static final routes = [
    GoRoute(
      path: AppRoutes.splash.routeName,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.gifSearch.routeName,
      builder: (_, __) => const SearchGifScreen(),
    ),
    GoRoute(
      path: AppRoutes.favoriteGifs.routeName,
      builder: (_, __) => const FavoriteGifsScreen(),
    ),
    GoRoute(
      path: AppRoutes.gifDetails.routeName,
      builder: (_, state) => GifDetailsScreen(model: state.extra! as GifModel),
    ),
  ];

  static final router = GoRouter(
    routes: routes,
    initialLocation: AppRoutes.splash.routeName,
  );
}
