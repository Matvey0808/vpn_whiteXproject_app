import "package:flutter/material.dart";
import "package:vpn_whitexproject_app/view/vpn_navigation_bar_view.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBarView(),
    );
  }
}