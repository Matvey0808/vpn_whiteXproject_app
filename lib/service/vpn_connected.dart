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
    return {
      "log": {"loglevel": "warning"},
      "dns": {
        "servers": [
          "fakedns",
          {"address": "https://1.1.1.1/dns-query", "queryStrategy": "UseIPv4"},
          {
            "address": "https://dns.adguard.com/dns-query",
            "queryStrategy": "UseIPv4",
          },
        ],
        "queryStrategy": "UseIPv4",
      },
      "inbounds": [
        {
          "port": 10808,
          "listen": "127.0.0.1",
          "protocol": "socks",
          "settings": {"udp": true},
          "sniffing": {
            "enabled": true,
            "destOverride": ["http", "tls", "fakedns"],
          },
        },
        {
          "port": 10809,
          "listen": "127.0.0.1",
          "protocol": "http",
          "settings": {"udp": true},
        },
      ],
      "outbounds": [
        {
          "tag": "proxy",
          "protocol": "vless",
          "settings": {
            "vnext": [
              {
                "address": "82.146.45.65",
                "port": 28935,
                "users": [
                  {
                    "id": "a0137aa8-64c2-4530-8406-49dab1ba8c96",
                    "encryption": "none",
                  },
                ],
              },
            ],
          },
          "streamSettings": {
            "network": "xhttp",
            "security": "reality",
            "realitySettings": {
              "serverName": "music.yandex.ru",
              "publicKey": "GtHFuOW36ynLan2UWFr1wSasnuLKY6KXP5uF00TROyA",
              "shortId": "a2cf615dde4e8d74",
              "fingerprint": "chrome",
            },
            "xhttpSettings": {
              "path": "/",
              "mode": "auto",
              "host": "music.yandex.ru",
              "scMaxEachPostBytes": 15000,
            },
            "fragment": {
              "packets": "1-3",
              "length": "14000-20000",
              "interval": "5-15",
            },
          },
          "sniffing": {
            "enabled": true,
            "destOverride": ["http", "tls"],
            "metadataOnly": false,
          },
        },
        {"protocol": "freedom", "tag": "direct"},
      ],
      "routing": {
        "rules": [
          {
            "type": "field",
            "ip": ["geoip:private"],
            "outboundTag": "direct",
          },
        ],
      },
    };
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
        notificationIconResourceName: "ic_launcher",
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
