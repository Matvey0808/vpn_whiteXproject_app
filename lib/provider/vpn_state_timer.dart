import 'package:flutter/material.dart';
import 'dart:async';

class VpnStateTimer extends ChangeNotifier {
  final ValueNotifier<int> secondsNotifier = ValueNotifier(0);
  Timer? _timer;

  int get seconds => secondsNotifier.value;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatedTimer() {
    final seconds = secondsNotifier.value % 60;
    final minutes = (secondsNotifier.value % 3600) ~/ 60;
    final hourse = secondsNotifier.value ~/ 3600;

    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = seconds.toString().padLeft(2, '0');
    final horStr = hourse.toString().padLeft(2, '0');

    return "${horStr}:${minStr}:${secStr}";
  }

  void timerVpn() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsNotifier.value++;
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
    secondsNotifier.value = 0;
    notifyListeners();
  }
}
