import 'package:flutter/material.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: width * 0.5,
        height: 100,
        child: Card(
          color: Colors.amber,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 35,
              horizontal: 98
            ),
          ),
        ),
      ),
    );
  }
}
