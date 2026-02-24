import 'package:flutter/material.dart';
import 'package:vpn_whitexproject_app/view/vpn_setting_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_whitexproject_app/widget/navigation_bar_widget.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      appBar: AppBar(
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
      ),
      body: Center(child: Text("vpn home")),
    );
  }
}

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({super.key});

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  int _currentIndex = 0;
  final List<Widget> views = [VpnHomeView(), VpnSettingView()];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isBreakpointWidth = width >= 600;
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: isBreakpointWidth ? width * 0.02 : width * 0.1,
        ),
        child: SafeArea(
          child: Container(
            height: 76,
            margin: EdgeInsets.symmetric(horizontal: width * 0.2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => _currentIndex = 1);
                        },
                        child: SvgPicture.asset(
                          "assets/settingsLogo.svg",
                          colorFilter: ColorFilter.mode(
                            _currentIndex == 1
                                ? Color(0xFF002FFF)
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          width: 1.5,
                          height: 10,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => _currentIndex = 0);
                        },
                        child: SvgPicture.asset(
                          "assets/vpnLogo.svg",
                          colorFilter: ColorFilter.mode(
                            _currentIndex == 0
                                ? Color(0xFF002FFF)
                                : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: views[_currentIndex],
    );
  }
}
