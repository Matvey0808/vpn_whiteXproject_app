import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VpnSettingView extends StatelessWidget {
  const VpnSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      body: Center(child: SvgPicture.asset("assets/whiteNet-logo 4.svg")),
    );
  }
}