import 'package:flutter/cupertino.dart';
import 'package:giphy_search/features/gif_search/services/giphy_service.dart';
import 'package:giphy_search/features/gif_search/services/giphy_service_impl.dart';
import 'package:giphy_search/features/gif_search/state/gif_search_notifier.dart';
import 'package:provider/provider.dart';

class Injector extends StatefulWidget {
  final Widget child;

  const Injector({required this.child, super.key});

  @override
  State<Injector> createState() => _InjectorState();
}

class _InjectorState extends State<Injector> {
  late final GiphyService _giphyService;

  @override
  void initState() {
    super.initState();

    _giphyService = GiphyServiceImpl();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GifSearchNotifier(_giphyService)),
      ],
      child: widget.child,
    );
  }
}
