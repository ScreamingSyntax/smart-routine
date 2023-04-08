import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:routine_app/controllers/local_storage.dart';
import 'package:routine_app/controllers/user_controller.dart';
import 'package:routine_app/models/sections.dart';
import 'package:routine_app/models/user.dart';
import 'package:routine_app/widgets/CircularMessage.dart';
import 'package:routine_app/widgets/homePage/home_page_content.dart';
import 'package:routine_app/widgets/homePage/home_page_top.dart';

class HomePageMain extends StatefulWidget {
  HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  Section sec = Section();
  UserController uc = UserController();
  LocalStorage ac = LocalStorage();
  String? tokenSave = null;
  String tokenRead = "";
  String? userNameKey = "aa";
  getToken() async {
    // setState(() {});
    if (UserDetail.details.isEmpty) {
      await uc.getProfile();
      setState(() {});
    }
    await uc.getProfile();
    await fetchSection();
  }

  Future fetchSection() async {
    try {
      Response response = await get(
          Uri.parse(
            "https://aaryansyproutineapplication.azurewebsites.net/api/routine/",
          ),
          headers: {"Content-Type": "application/json"});
      sec = Section.fromJson(json.decode(response.body));
      setState(() {});
      print(sec.data![0].sectionName!);
      // for (int i = 0; i < sec.data!.length; i++) {
      //   print(sec.data![i].sectionName);
      // }
    } catch (e) {
      print("Something went wrong");
    }
  }

  firstName() {
    var split = UserDetail.details[0].name.split(" ");
    // var split = "";
    return split[0];
  }

  initState() {
    super.initState();
    print("Init State Called");
    getToken();
  }

  final section = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      semanticsLabel: "Refreshing",
      backgroundColor: Colors.cyan,
      color: Colors.black,
      onRefresh: () {
        setState(() {});
        return uc.getProfile();
      },
      child: UserDetail.details.isEmpty
          ? MyCircularProgressBar(context, "Fetching User Data")
          : Scaffold(
              backgroundColor: Colors.cyan,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            HomePageTop(firstName: firstName()),
                            HomePageContent(
                              sec: sec,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
