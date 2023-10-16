import 'package:flutter/cupertino.dart';
import 'package:giphy_search/constants/app_colors.dart';

class AppbarBlueButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const AppbarBlueButton({required this.icon, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.accentPrimaryColor,
          ),
          child: icon,
        ),
      ),
    );
  }
}
