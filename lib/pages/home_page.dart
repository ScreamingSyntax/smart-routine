import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:routine_app/pages/main_pages/home_page.dart';
import 'package:routine_app/pages/main_pages/profile_page.dart';
import 'package:routine_app/pages/main_pages/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [HomePageMain(), SettingsPage(), ProfilePageeMain()];

  final _navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 1;

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.settings,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.people_alt_rounded,
      size: 30,
      color: Colors.white,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        key: _navigationKey,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.black,
        height: 60,
        items: items,
        animationCurve: Curves.easeInOutQuint,
        index: index,
        onTap: (index) => {this.index = index, setState(() => {})},
      ),
    );
  }
}
