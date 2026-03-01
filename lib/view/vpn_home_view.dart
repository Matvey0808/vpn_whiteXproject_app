import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  Color? _isColor = Colors.black;
  bool _isColorBool = false;

  void _changeColor() {
    setState(() {
      _isColor = _isColorBool ? Color(0xFF002FFF) : Colors.black;
      _isColorBool = !_isColorBool;
    });
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
                    _changeColor();
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
