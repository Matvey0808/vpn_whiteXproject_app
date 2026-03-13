import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_whitexproject_app/service/vpn_service.dart';
import 'dart:async';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  Color? _isColor = Colors.black;
  bool _isColorBool = false;
  bool _isStartStop = false;
  final ValueNotifier<int> secondsNotifier = ValueNotifier(0);
  Timer? _timer;

  void _changeColor() {
    setState(() {
      _isColor = _isColorBool ? Color(0xFF002FFF) : Colors.black;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _timerVpn() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsNotifier.value++;
    });
  }

  void _stop() {
    _timer?.cancel();
    secondsNotifier.value = 0;
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
                  onTap: () async {
                    setState(() {
                      if (_isColorBool == false) {
                        _timerVpn();
                      } else {
                        _stop();
                      }
                      print(_isColorBool);
                      _isColorBool = !_isColorBool;
                      _changeColor();
                      _isStartStop = !_isStartStop;
                      _isStartStop == false
                          ? VpnService.stopService()
                          : VpnService.startService();
                    });
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
              Text(
                "disconnected",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Afacad",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: secondsNotifier,
                builder: (context, seconds, timer) {
                  print("Перерисовался build");
                  final seconds = secondsNotifier.value % 60;
                  final minutes = (secondsNotifier.value % 3600) ~/ 60;
                  final hourse = secondsNotifier.value ~/ 3600;

                  final minStr = minutes.toString().padLeft(2, '0');
                  final secStr = seconds.toString().padLeft(2, '0');
                  final horStr = hourse.toString().padLeft(2, '0');
                  return Text(
                    "${horStr}:${minStr}:${secStr}",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Afacad",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
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
      toolbarHeight: 70,
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
                    "assets/whiteNetLogo.svg",
                    width: isBreakpointWidth
                        ? widthConstraints * 0.2
                        : widthConstraints * 0.32,
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
