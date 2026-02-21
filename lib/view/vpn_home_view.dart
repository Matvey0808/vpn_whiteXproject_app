import 'package:flutter/material.dart';
import 'package:vpn_whitexproject_app/view/vpn_setting_view.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  int _currentIndex = 0;
  final List<Widget> views = [VpnHomeView(), VpnSettingView()];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xFF161414),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final widthConstraints = constraints.maxWidth;
            final isBreakpointWidth = widthConstraints >= 600;
            return Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset("assets/logo 2.png", fit: BoxFit.contain),
                    Positioned(
                      bottom: 50,
                      left: 70,
                      child: Text(
                        "whiteX.project",
                        style: TextStyle(
                          fontSize: isBreakpointWidth ? 22 : 18,
                          color: Colors.white,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: width * 0.1),
        child: SafeArea(
          child: Container(
            height: 76,
            margin: EdgeInsets.symmetric(horizontal: width * 0.25),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.5, color: Colors.black12),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => _currentIndex = 0);
                  },
                  child: Image.asset(
                    "assets/IconSettings.png",
                    color: _currentIndex == 0 ? Colors.blue : Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _currentIndex = 1);
                  },
                  child: Image.asset(
                    "assets/iconVpn.png",
                    color: _currentIndex == 1 ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
