import 'package:flutter/material.dart';
import 'dart:async';

class VpnStateTimer extends ChangeNotifier {
  final durationNotifier = ValueNotifier(Duration.zero);
  Timer? _timer;

  Duration get duration => durationNotifier.value;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void timerVpn() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      durationNotifier.value += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
    durationNotifier.value = Duration.zero;
    notifyListeners();
  }
}
