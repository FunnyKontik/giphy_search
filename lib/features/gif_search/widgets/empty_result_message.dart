import 'package:flutter/cupertino.dart';

import 'package:giphy_search/constants/app_colors.dart';
import 'package:giphy_search/constants/app_text_styles.dart';

class EmptyResultMessage extends StatelessWidget {
  final List<String> message;

  const EmptyResultMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.bodyTextStyle
        .copyWith(color: AppColors.textPlaceholderColor);

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: message
            .map(
              (e) => Text(
                e,
                style: textStyle,
              ),
            )
            .toList(),
      ),
    );
  }
}
