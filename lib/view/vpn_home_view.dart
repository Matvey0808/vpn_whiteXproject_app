import 'package:flutter/material.dart';
import 'package:vpn_whitexproject_app/view/vpn_setting_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_whitexproject_app/service/vpn_connected.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  Color? _isColor = Colors.black;
  bool _isColorBool = false;

  bool _isConnected = false;
  bool _isConnecting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    VpnConnected().onStatusChanged = (connected, connecting) {
      if (mounted) {
        setState(() {
          _isConnected = connected;
          _isConnecting = connecting;
        });
      }
    };

    VpnConnected().init();
  }

  Color _changeColor() {
    if (_isConnected) return const Color(0xFF002FFF);
    return Colors.black;
  }

  Future<void> _tapVpn() async {
    if (_isConnecting) return;

    try {
      if (_isConnected) {
        await VpnConnected().disconnect();
      } else {
        String? error = await VpnConnected().connect();

        if (error != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Неизвестная ошибка: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    VpnConnected().onStatusChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      appBar: _AppBarVpn(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isBreakPointWidth = width >= 600;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: isBreakPointWidth ? width * 0.01 : width * 0.4),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _tapVpn();
                  },
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(begin: _isColor, end: _isColor),
                    duration: Duration(milliseconds: 300),
                    builder: (context, color, child) {
                      return SvgPicture.asset(
                        "assets/logoConnect.svg",
                        width: isBreakPointWidth ? width * 0.18 : width * 0.5,
                        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: isBreakPointWidth ? width * 0.01 : width * 0.1),
              _isConnecting
                  ? const Text(
                      "connecting...",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Afacad",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : _isConnected
                  ? const Text(
                      "connected",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Afacad",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Text(
                      "disconnected",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Afacad",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              Text(
                "00:00:00",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Afacad",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  //////////////////////////////////////
  /////////////////////////////////////////
  PreferredSizeWidget _AppBarVpn() {
    return AppBar(
      backgroundColor: Color(0xFFFFFDFA),
      toolbarHeight: 90,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final widthConstraints = constraints.maxWidth;
          final isBreakpointWidth = widthConstraints >= 600;
          return Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/logo4.svg",
                    width: isBreakpointWidth
                        ? widthConstraints * 0.1
                        : widthConstraints * 0.2,
                  ),
                  Positioned(
                    top: isBreakpointWidth ? 27 : 23,
                    left: isBreakpointWidth ? 51 : 45,
                    child: Text(
                      "whiteX.project",
                      style: TextStyle(
                        fontFamily: "Afacad",
                        fontSize: isBreakpointWidth ? 22 : 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  //////////////////////////////////////
  /////////////////////////////////////////
}
