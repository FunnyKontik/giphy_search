import 'package:flutter/material.dart';
import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/constants/app_text_styles.dart';
import 'package:giphy_search/widgets/svg_icon.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClearInput;

  const SearchTextField({
    required this.controller,
    required this.onChanged,
    this.onClearInput,
    super.key,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  static const _borderRadius = BorderRadius.all(Radius.circular(50));

  Color _backgroundColor = AppColors.layerColor;
  SvgIcon? _suffixIcon;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_textControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _onFocusChange,
      child: SizedBox(
        height: 56,
        child: TextFormField(
          controller: widget.controller,
          style: AppTextStyles.bodyTextStyle,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Search',
            hintStyle: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.textPlaceholderColor),
            prefixIcon: _prefixIcon(),
            suffixIcon: _suffixIcon,
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: AppColors.accentPrimaryColor),
              borderRadius: _borderRadius,
            ),
            fillColor: _backgroundColor,
            border: const OutlineInputBorder(
              borderRadius: _borderRadius,
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _prefixIcon() {
    return const SvgIcon(
      asset: 'assets/icons/search.svg',
      color: AppColors.accentPrimaryColor,
      size: 50,
    );
  }

  void _onFocusChange(bool hasFocus) {
    setState(() {
      _backgroundColor =
          hasFocus ? AppColors.accentSecondaryColor : AppColors.layerColor;
    });
  }

  void _textControllerListener() {
    if (widget.controller.text.isEmpty && _suffixIcon != null) {
      setState(() {
        _suffixIcon = null;
      });
    } else if (widget.controller.text.isNotEmpty && _suffixIcon == null) {
      setState(() {
        _suffixIcon = SvgIcon(
          asset: 'assets/icons/close.svg',
          color: AppColors.accentPrimaryColor,
          onTap: _clearInput,
        );
      });
    }
  }

  void _clearInput() {
    widget.controller.clear();
    widget.onClearInput?.call();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_textControllerListener);
    super.dispose();
  }
}
