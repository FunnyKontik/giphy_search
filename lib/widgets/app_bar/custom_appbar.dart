import 'package:flutter/material.dart';
import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final Widget? leading;
  final List<Widget> actions;

  const CustomAppBar({
    required this.appbarTitle,
    this.actions = const [],
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: Container(
          color: AppColors.layerColor,
          height: 3,
          margin: const EdgeInsets.only(bottom: 20),
        ),
      ),
      leading: leading,
      backgroundColor: AppColors.mainBackgroundColor,
      title: Text(
        appbarTitle,
        style: AppTextStyles.headerTextStyle.copyWith(
          color: Colors.black,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
