import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePageMain extends StatefulWidget {
  HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  FlutterSecureStorage token = FlutterSecureStorage();
  String? tokenSave = null;
  String tokenRead = "";
  String userName = "";
  String? userEmail = null;
  int userID = 0;
  var firstName = "";

  String? userNameKey = "";
  getToken() async {
    print("User Name key" + userNameKey!);
    String? tokenRead = await token.read(key: 'token');
    setState(() {
      tokenSave = tokenRead;
    });
  }

  splitNames() async {
    userNameKey = await token.read(key: 'username');
    // List<String> firstNameSplit = userNameKey!.split(" ");
    // return firstNameSplit[0];
    // print(userNameKey! + "AAA");
    setState(() {});
  }

  getProfile() async {
    if (userName == "") {
      userEmail = await token.read(key: 'email');
      print(userEmail);
      final response = await http.get(
        Uri.parse(
            'https://aaryansyproutineapplication.azurewebsites.net/api/users/${userEmail}'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Barear ${await token.read(key: 'token') as String}'
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json["success"] == 1) {
          userName = json["message"][0]["name"];
          userID = json["message"][0]["id"];
          print(userID);
        }
        await token.write(key: "id", value: userID.toString());
        await token.write(key: "username", value: userName);
      }

      // setState(() {});
      // print(token.read(key: 'email') as String);
      // final responseJson = jsonDecode(response.body);
    }
  }

  initState() {
    super.initState();
    print("Init State Called");
    getToken();
    splitNames();
    getProfile();
  }

  final section = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: SafeArea(
          child: Column(
            children: [
              VxArc(
                  height: 15,
                  arcType: VxArcType.CONVEX,
                  edge: VxEdge.BOTTOM,
                  child: Container(
                    color: Theme.of(context).colorScheme.onPrimary,
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
                                .make(),
                            "${userNameKey}"
                                .text
                                .textStyle(context.captionStyle)
                                .fontWeight(FontWeight.bold)
                                .size(30)
                                .make()
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(9)),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.sunny,
                              color: Colors.yellow,
                              size: 30,
                            ))
                      ],
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      "Your Modules"
                          .text
                          .fontWeight(FontWeight.bold)
                          .size(30)
                          .make()
                          .p16(),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    height: 500,
                    child: ListView.builder(
                      itemCount: section.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.backpack,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Section ${section[index]}"
                                        .text
                                        .bold
                                        .xl
                                        .make(),
                                    "Total Students  = 100".text.make()
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
