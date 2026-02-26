import 'package:flutter_v2ray_client/flutter_v2ray.dart';
import 'dart:convert';

class VpnConnected {
  static final VpnConnected _instance = VpnConnected._internal();
  factory VpnConnected() => _instance;
  VpnConnected._internal();

  late V2ray _v2ray;
  bool _isInit = false;
  bool _isConnected = false;
  bool _isConnecting = false;

  bool get isConnected => _isConnected;
  bool get isConnecting => _isConnecting;

  Function(bool isConnected, bool isConnecting)? onStatusChanged;

  Map<String, dynamic> _configVpn() {
    return {};
  }

  String _getConfigString() {
    return json.encode(_configVpn());
  }

  Future<void> init() async {
    if (_isInit) return;

    _v2ray = V2ray(
      onStatusChanged: (status) {
        print("VPN status: ${status.state}");
        if (status.state == "disconnected") {
          _isConnected = false;
          _isConnecting = false;
          _notifyStatusChange();
        }
      },
    );

    try {
      await _v2ray.initialize(
        notificationIconResourceType: "mipmap",
        notificationIconResourceName: "ic_launcher"
      );
      _isInit = true;
    } catch (e) {
      print("Ошибка инициализации впн: $e");
    }
  }

  Future<String?> connect() async {
    if (_isConnecting) return null;

    _isConnecting = true;
    _notifyStatusChange();

    try {
      if (!_isInit) await init();
      bool permissionGranted = await _v2ray.requestPermission();

      if (!permissionGranted) {
        _isConnecting = false;
        _notifyStatusChange();
        return "Нет разрешения на впн";
      }

      _v2ray.startV2Ray(
        remark: "whiteXvpn",
        config: _getConfigString(),
        proxyOnly: false,
      );

      _isConnected = true;
      _isConnecting = false;
      _notifyStatusChange();
      return null;
    } catch (e) {
      _isConnected = false;
      _isConnecting = false;
      _notifyStatusChange();
      return "Ошибка: $e";
    }
  }

  Future<void> disconnect() async {
    _v2ray.stopV2Ray();
    _isConnected = false;
    _isConnecting = false;
    _notifyStatusChange();
  }

  Future<int?> getDelay() async {
    try {
      return await _v2ray.getServerDelay(config: _getConfigString());
    } catch (e) {
      print("Ошибка получения задержки: $e");
      return null;
    }
  }

  void _notifyStatusChange() {
    onStatusChanged?.call(_isConnected, _isConnecting);
  }

  void dispose() {
    _v2ray.stopV2Ray();
  }
}