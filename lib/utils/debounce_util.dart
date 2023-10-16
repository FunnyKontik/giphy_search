import 'dart:async';
import 'dart:ui';

class DebounceUtil {
  final Duration debounceTime;
  Timer? _timer;

  bool get isRunning => _timer?.isActive ?? false;

  DebounceUtil({required this.debounceTime});

  void run(VoidCallback action) {
    _timer?.cancel();

    _timer = Timer(debounceTime, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
