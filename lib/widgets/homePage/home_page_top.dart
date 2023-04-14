import 'package:flutter/material.dart';
import 'package:routine_app/main.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageTop extends StatefulWidget {
  final firstName;
  final GlobalKey homePageMainStateKey;
  const HomePageTop(
      {super.key, required this.firstName, required this.homePageMainStateKey});

  @override
  State<HomePageTop> createState() => _HomePageTopState();
}

class _HomePageTopState extends State<HomePageTop> {
  //  final _homePageMainState = GlobalKey<m>()
  @override
  Widget build(BuildContext context) {
    return VxArc(
        // key: widget.key,
        height: 15,
        arcType: VxArcType.CONVEX,
        edge: VxEdge.BOTTOM,
        child: Container(
          color: MyApp.lightThemeData ? Colors.blue : Colors.black,
          padding: EdgeInsets.all(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Hello "
                      .text
                      .fontWeight(FontWeight.bold)
                      .size(20)
                      .color(MyApp.lightThemeData ? Colors.black : Colors.white)
                      .make(),
                  "${widget.firstName}"
                      .text
                      .textStyle(context.captionStyle)
                      .fontWeight(FontWeight.bold)
                      .color(MyApp.lightThemeData ? Colors.black : Colors.white)
                      .size(30)
                      .make()
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      color: MyApp.lightThemeData ? Colors.cyan : Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                      onTap: () {
                        MyApp.lightThemeData = !MyApp.lightThemeData;
                        setState(() {});
                        widget.homePageMainStateKey.currentState
                            ?.setState(() {});
                        print(MyApp.lightThemeData);
                      },
                      child: MyApp.lightThemeData
                          ? Icon(
                              Icons.sunny,
                              color: Colors.yellow,
                              size: 30,
                            )
                          : Icon(
                              Icons.nightlight,
                              color: Colors.black,
                              size: 30,
                            )))
            ],
          ),
        ));
  }
}
