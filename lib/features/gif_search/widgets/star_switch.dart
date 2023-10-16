import 'package:flutter/cupertino.dart';

import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/widgets/svg_icon.dart';

class StarSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const StarSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  State<StarSwitch> createState() => _StarSwitchState();
}

class _StarSwitchState extends State<StarSwitch> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant StarSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SvgIcon(
        asset: 'assets/icons/star.svg',
        color: _value
            ? AppColors.accentPrimaryColor
            : AppColors.textPlaceholderColor,
      ),
    );
  }

  void _onTap() {
    setState(() {
      _value = !_value;
    });

    widget.onChanged(_value);
  }
}
