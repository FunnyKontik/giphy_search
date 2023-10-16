import 'package:flutter/material.dart';
import 'package:giphy_search/constants/navigation.dart';
import 'package:giphy_search/state/injector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Injector(
      child: MaterialApp.router(
        title: 'Giphy search',
        routerConfig: Navigation.router,
      ),
    );
  }
}
