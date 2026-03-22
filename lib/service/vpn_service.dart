import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class VpnService {
  static const platform = MethodChannel('vpn');

  static Future<void> startService() async {
    final status = await Permission.notification.request();

    if (status.isGranted) {
      await platform.invokeMethod('startService');
    } else {
      log('Notification permission not granted');
    }
  }

  static Future<void> stopService() async {
    final result = await platform.invokeMethod('stopService');
    log('$result');
  }
}
