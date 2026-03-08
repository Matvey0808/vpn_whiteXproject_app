import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class VpnService {
  static const platform = MethodChannel("vpn");

  static Future<void> startService() async {
    var status = await Permission.notification.request();

    if (status.isGranted) {
      await platform.invokeMethod("startService");
    } else {
      print("None");
    }
  }

  static Future<void> stopService() async {
    final result = await platform.invokeMethod("stopService");
    print(result);
  }
}
