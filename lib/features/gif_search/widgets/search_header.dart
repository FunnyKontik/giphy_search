import 'package:flutter/cupertino.dart';

import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/constants/app_text_styles.dart';

class SearchHeader extends StatelessWidget {
  final String text;

  const SearchHeader({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.headerTextStyle
          .copyWith(color: AppColors.accentPrimaryColor),
    );
  }
}
