import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:routine_app/controllers/user_controller.dart';
import 'package:routine_app/main.dart';

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
  UserController uc = UserController();
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
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: RefreshIndicator(
        semanticsLabel: "Refreshing",
        backgroundColor: Colors.cyan,
        color: Colors.black,
        onRefresh: () {
          setState(() {});
          return uc.getProfile();
        },
        child: Scaffold(
          body: screens[index],
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            color: MyApp.lightThemeData ? Colors.blue : Colors.black,
            key: _navigationKey,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor:
                MyApp.lightThemeData ? Colors.blue : Colors.black,
            height: 60,
            items: items,
            animationCurve: Curves.easeInOutQuint,
            index: index,
            onTap: (index) => {this.index = index, setState(() => {})},
          ),
        ),
      ),
    );
  }
}
