import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/constants/app_text_styles.dart';
import 'package:giphy_search/widgets/svg_icon.dart';

class SearchHistoryItem extends StatelessWidget {
  final String searchText;
  final VoidCallback onTap;

  const SearchHistoryItem({
    required this.searchText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.layerColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  searchText,
                  style: AppTextStyles.bodyTextStyle,
                ),
              ),
              const RotatedBox(
                quarterTurns: 2,
                child: SvgIcon(
                  asset: 'assets/icons/left.svg',
                  size: 18,
                  color: AppColors.accentPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
