import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class VpnService {
  static const platform = MethodChannel('vpn');

  static Future<void> startService(String configJson) async {
    final status = await Permission.notification.request();

    if (status.isGranted) {
      await platform.invokeMethod('startService', configJson);
    } else {
      log('Notification permission not granted');
    }
  }

  static Future<void> stopService() async {
    final result = await platform.invokeMethod('stopService');
    log('$result');
  }

  static Future<bool> isRunning() async {
    final result = await platform.invokeMethod<bool>('isRunning');
    return result ?? false;
  }

  static Future<String> getVersion() async {
    final result = await platform.invokeMethod<String>('getVersion');
    return result ?? '';
  }
}
