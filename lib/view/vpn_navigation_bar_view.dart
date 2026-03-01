import 'package:flutter/material.dart';
import 'package:vpn_whitexproject_app/view/vpn_home_view.dart';
import 'package:vpn_whitexproject_app/view/vpn_setting_view.dart';
import 'package:flutter_svg/svg.dart';

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({super.key});

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  int _currentIndex = 0;
  final List<Widget> views = const [VpnHomeView(), VpnSettingView()];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isBreakpointWidth = width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDFA),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = 1),
                      child: SvgPicture.asset(
                        "assets/settingsLogo.svg",
                        colorFilter: ColorFilter.mode(
                          _currentIndex == 1
                              ? const Color(0xFF002FFF)
                              : Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(width: 1.5, height: 15, color: Colors.black),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = 0),
                      child: SvgPicture.asset(
                        "assets/vpnLogo.svg",
                        colorFilter: ColorFilter.mode(
                          _currentIndex == 0
                              ? const Color(0xFF002FFF)
                              : Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
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
