import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String asset;
  final Color color;
  final double size;
  final VoidCallback? onTap;

  const SvgIcon({
    required this.asset,
    this.color = Colors.white,
    this.size = 20.0,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: SvgPicture.asset(
        asset,
        height: size,
        width: size,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
