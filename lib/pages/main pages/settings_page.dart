import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:routine_app/main.dart';
import 'package:routine_app/models/announcements.dart';
import 'package:routine_app/routes/my_routes.dart';
import 'package:routine_app/widgets/CircularMessage.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  Announcements am = Announcements();
  Future fetchAnnouncements() async {
    try {
      Response response = await get(
          Uri.parse(
            "https://aaryansyproutineapplication.azurewebsites.net/api/announcement/",
          ),
          headers: {"Content-Type": "application/json"});
      am = Announcements.fromJson(json.decode(response.body));
      setState(() {});
      print(am.data!.length);
    } catch (e) {
      print("Something went wrong");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return am.data == null
        ? MyCircularProgressBar(context, "Fetching Announcements",
            color: MyApp.lightThemeData == false
                ? Color(0xff28282B)
                : Colors.white,
            foreGroundColor:
                MyApp.lightThemeData == false ? Colors.white : Colors.black)
        : Scaffold(
            backgroundColor:
                MyApp.lightThemeData ? Colors.cyanAccent : Color(0xff28282B),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VxArc(
                      height: 15,
                      arcType: VxArcType.CONVEX,
                      edge: VxEdge.BOTTOM,
                      child: Container(
                        // height: 200,
                        alignment: Alignment.center,
                        color:
                            MyApp.lightThemeData ? Colors.blue : Colors.black,
                        padding: EdgeInsets.all(50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Announcements "
                                    .text
                                    .fontWeight(FontWeight.bold)
                                    .size(20)
                                    .color(MyApp.lightThemeData
                                        ? Colors.black
                                        : Colors.white)
                                    .make(),
                                // "This is announcements"
                                //     .text
                                //     .textStyle(context.captionStyle)
                                //     .fontWeight(FontWeight.bold)
                                //     .size(19)
                                //     .make()
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(9)),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.speaker_group,
                                  color: Colors.yellow,
                                  size: 30,
                                ))
                          ],
                        ),
                      )),
                  "Currently Posted"
                      .text
                      .fontWeight(FontWeight.bold)
                      .size(30)
                      .color(MyApp.lightThemeData ? Colors.black : Colors.white)
                      .make()
                      .p16(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: am.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyApp.lightThemeData
                                      ? Colors.white
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  ListTile(
                                    trailing: Icon(Icons.star),
                                    leading: Icon(
                                      Icons.label,
                                      color: Colors.blue,
                                    ),
                                    title: Text(
                                      "${am.data![index].name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MyApp.lightThemeData
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${am.data![index].title}",
                                      style: TextStyle(
                                        color: MyApp.lightThemeData
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${am.data![index].description}",
                                      style: TextStyle(
                                        color: MyApp.lightThemeData
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
