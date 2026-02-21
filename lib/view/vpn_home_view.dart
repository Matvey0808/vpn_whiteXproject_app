import 'package:flutter/material.dart';

class VpnHomeView extends StatefulWidget {
  const VpnHomeView({super.key});

  @override
  State<VpnHomeView> createState() => _VpnHomeViewState();
}

class _VpnHomeViewState extends State<VpnHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          fontSize: isBreakpointWidth ? 20 : 16,
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
    );
  }
}
