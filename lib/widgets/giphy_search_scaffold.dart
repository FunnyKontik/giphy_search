import 'package:flutter/material.dart';

class GiphySearchScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget appBar;

  const GiphySearchScaffold({
    required this.body,
    required this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const pagePadding = EdgeInsets.symmetric(horizontal: 12);

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: pagePadding,
        child: body,
      ),
    );
  }
}
