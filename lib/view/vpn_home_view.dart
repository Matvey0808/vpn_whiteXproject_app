import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_whitexproject_app/provider/vpn_state_button.dart';
import 'package:vpn_whitexproject_app/provider/vpn_state_timer.dart';
import 'package:vpn_whitexproject_app/service/vpn_service.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  bool _isStartTimer = false;

  @override
  Widget build(BuildContext context) {
    final timer = context.read<VpnStateTimer>();
    final buttonColor = context.read<VpnStateButton>();
    print("Перерисовался");

    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      appBar: AppBar(
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
                      "assets/whiteNet-logo 4.svg",
                      width: isBreakpointWidth
                          ? widthConstraints * 0.16
                          : widthConstraints * 0.32,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isBreakPointWidth = width >= 600;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: isBreakPointWidth ? width * 0.01 : width * 0.4),
              Center(
                /////////////////////////////
                /////////////////////////////
                child: ValueListenableBuilder(
                  valueListenable: buttonColor.connectionColor,
                  builder: (context, value, _) {
                    final colorButton = context.read<VpnStateButton>();
                    print("Перерисовался buildNotifier2");
                    return GestureDetector(
                      onTap: () async {
                        if (colorButton.isColorBool == false) {
                          timer.timerVpn();
                        } else {
                          timer.stop();
                        }
                        colorButton.isColorBool = !colorButton.isColorBool;
                        colorButton.changeColor();
                        _isStartTimer = !_isStartTimer;
                        _isStartTimer == false
                            ? VpnService.stopService()
                            : VpnService.startService();
                      },
                      child: TweenAnimationBuilder<Color?>(
                        tween: ColorTween(
                          begin: colorButton.connectionColor.value,
                          end: colorButton.connectionColor.value,
                        ),
                        duration: Duration(milliseconds: 300),
                        builder: (context, color, child) {
                          return SvgPicture.asset(
                            "assets/logoConnect.svg",
                            width: isBreakPointWidth
                                ? width * 0.18
                                : width * 0.5,
                            colorFilter: ColorFilter.mode(
                              color!,
                              BlendMode.srcIn,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                /////////////////////////////
                /////////////////////////////
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
                valueListenable: timer.secondsNotifier,
                builder: (context, seconds, timer) {
                  print("Перерисовался buildNotifier1");
                  final timer = context.read<VpnStateTimer>();

                  return Text(
                    "${timer.formatedTimer()}",
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
}
