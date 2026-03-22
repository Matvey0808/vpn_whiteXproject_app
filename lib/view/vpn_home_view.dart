import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_whitexproject_app/provider/vpn_state_button.dart';
import 'package:vpn_whitexproject_app/provider/vpn_state_timer.dart';
import 'package:vpn_whitexproject_app/service/vpn_service.dart';
import 'package:provider/provider.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  bool _isStartTimer = false;

  String _formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  Future<void> _onConnectionTap(
    VpnStateTimer timer,
    VpnStateButton colorButton,
  ) async {
    if (colorButton.isColorBool == false) {
      timer.timerVpn();
    } else {
      timer.stop();
    }
    colorButton
      ..isColorBool = !colorButton.isColorBool
      ..changeColor();
    _isStartTimer = !_isStartTimer;
    _isStartTimer == false
        ? await VpnService.stopService()
        : await VpnService.startService('{}');
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.read<VpnStateTimer>();
    final buttonColor = context.read<VpnStateButton>();
    log('VpnHomeView build');

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDFA),
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
                      'assets/whiteNet-logo 4.svg',
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
            children: [
              SizedBox(
                height: isBreakPointWidth ? width * 0.01 : width * 0.4,
              ),
              Center(
                child: ValueListenableBuilder(
                  valueListenable: buttonColor.connectionColor,
                  builder: (context, value, _) {
                    final colorButton = context.read<VpnStateButton>();
                    log('VpnHomeView connectionColor rebuild');
                    return GestureDetector(
                      onTap: () => _onConnectionTap(timer, colorButton),
                      child: TweenAnimationBuilder<Color?>(
                        tween: ColorTween(
                          begin: colorButton.connectionColor.value,
                          end: colorButton.connectionColor.value,
                        ),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, color, child) {
                          return SvgPicture.asset(
                            'assets/logoConnect.svg',
                            width: isBreakPointWidth
                                ? width * 0.18
                                : width * 0.63,
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
              ),
              SizedBox(
                height: isBreakPointWidth ? width * 0.01 : width * 0.06,
              ),
              Stack(
                children: [
                  const Align(
                    child: Text(
                      'disconnected',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Afacad',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: timer.durationNotifier,
                    builder: (context, duration, timer) {
                      log('VpnHomeView timer rebuild');
                      final width = MediaQuery.of(context).size.width;
                      final isWidth = width >= 600;

                      return Align(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: isWidth ? width * 0.02 : width * 0.05,
                          ),
                          child: Text(
                            _formatDuration(duration),
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Afacad',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
