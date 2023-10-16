import 'package:flutter/cupertino.dart';

class CustomActivityIndicator extends StatelessWidget {
  final double radius;
  final Color? color;

  const CustomActivityIndicator({
    this.radius = 14,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius,
      color: color,
    );
  }
}
