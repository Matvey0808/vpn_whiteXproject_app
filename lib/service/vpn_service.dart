import 'package:flutter/services.dart';

class VpnService {
  static const platform = MethodChannel("vpn");

  static Future<void> startService() async {
    final result = await platform.invokeMethod("startService");
    print(result);
  }

  static Future<void> stopService() async {
    final result = await platform.invokeMethod("stopService");
    print(result);
  }
}