import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vpn_whitexproject_app/provider/vpn_state_button.dart";
import "package:vpn_whitexproject_app/provider/vpn_state_timer.dart";
import "package:vpn_whitexproject_app/view/vpn_navigation_bar_view.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VpnStateTimer()),
        ChangeNotifierProvider(create: (_) => VpnStateButton())
      ],
      child: MyApp(),
    ),
  );
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
