import 'package:flutter/material.dart';

class VpnStateButton extends ChangeNotifier {
  bool isColorBool = false;
  final connectionColor = ValueNotifier<Color>(Colors.black);

  void changeColor() {
    isColorBool == false
        ? connectionColor.value = Colors.black
        : connectionColor.value = const Color(0xFF0000B3);
    notifyListeners();
  }
}
