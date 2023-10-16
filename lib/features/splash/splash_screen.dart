import 'package:flutter/material.dart';
import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/constants/app_text_styles.dart';
import 'package:giphy_search/constants/navigation.dart';
import 'package:giphy_search/features/gif_search/state/gif_search_notifier.dart';
import 'package:giphy_search/widgets/custom_activity_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context
        .read<GifSearchNotifier>()
        .addListener(_repositoryNotifierListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Giphy Search',
              style:
                  AppTextStyles.headerTextStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomActivityIndicator(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _repositoryNotifierListener() {
    if (mounted && context.read<GifSearchNotifier>().isInitialized) {
      context.go(AppRoutes.gifSearch.routeName);
    }
  }
}
