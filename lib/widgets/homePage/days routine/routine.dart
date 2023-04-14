import 'package:flutter/material.dart';
import 'package:routine_app/models/sections.dart';

import '../../../main.dart';
import '../../../themes/my_themes.dart';

class Routine extends StatelessWidget {
  final List<Classes> classes;
  const Routine({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (MyApp.lightThemeData ? Colors.white : Color(0xff28282B)),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: (MyApp.lightThemeData
                              ? Colors.white
                              : Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 0.1)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(13),
                            leading: Image.asset("assets/images/splash5.png"),
                            title: Text("${classes[index].className}",
                                style: TextStyle(
                                    color: (MyApp.lightThemeData
                                        ? MyThemes.bluishColor
                                        : Colors.white),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text("${classes[index].classType}"),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.assignment,
                                color: (MyApp.lightThemeData
                                    ? MyThemes.bluishColor
                                    : Colors.white),
                              ),
                              label: Text(
                                "${classes[index].moduleTeacher}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: (MyApp.lightThemeData
                                      ? MyThemes.bluishColor
                                      : Colors.white),
                                ),
                              )),
                          TextButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.class_,
                                color: (MyApp.lightThemeData
                                    ? MyThemes.bluishColor
                                    : Colors.white),
                              ),
                              label: Text(
                                "${classes[index].classType}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: (MyApp.lightThemeData
                                      ? MyThemes.bluishColor
                                      : Colors.white),
                                ),
                              )),
                          TextButton.icon(
                              onPressed: null,
                              icon: Icon(
                                Icons.timelapse,
                                color: (MyApp.lightThemeData
                                    ? MyThemes.bluishColor
                                    : Colors.white),
                              ),
                              label: Text(
                                "${classes[index].timePeriod}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: (MyApp.lightThemeData
                                      ? MyThemes.bluishColor
                                      : Colors.white),
                                ),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
