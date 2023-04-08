import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:routine_app/pages/main%20pages/home_page.dart';
import 'package:routine_app/pages/main%20pages/profile_page.dart';
import 'package:routine_app/pages/main%20pages/settings_page.dart';
import 'package:routine_app/widgets/PopScope.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [HomePageMain(), SettingsPage(), ProfilePageeMain()];

  final _navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  final items = <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.settings,
      size: 30,
    ),
    Icon(
      Icons.people_alt_rounded,
      size: 30,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: screens[index],
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          key: _navigationKey,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          height: 60,
          items: items,
          animationCurve: Curves.easeInOutQuint,
          index: index,
          onTap: (index) => {this.index = index, setState(() => {})},
        ),
      ),
    );
  }
}
