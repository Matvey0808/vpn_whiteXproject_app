import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VpnStateButton extends ChangeNotifier {
  bool isColorBool = false;
  final ValueNotifier<Color> connectionColor = ValueNotifier<Color>(Colors.black);

  void changeColor() {
    isColorBool == false ? connectionColor.value = Colors.black : connectionColor.value = Color(0xFF0000B3);
    notifyListeners();
  }
}