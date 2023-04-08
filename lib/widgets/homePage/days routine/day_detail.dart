// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:routine_app/models/sections.dart';

import 'package:routine_app/widgets/homePage/days%20routine/routine.dart';

import 'package:velocity_x/velocity_x.dart';

class DaysDetail extends StatelessWidget {
  final Data section;
  DaysDetail({
    Key? key,
    required this.section,
  }) : super(key: key);
  final iconList = [
    Icon(
      Icons.sunny,
      color: Colors.yellow,
    ),
    Icon(
      Icons.route,
      color: Colors.deepPurple,
    ),
    Icon(
      Icons.access_alarm,
      color: Colors.deepOrange,
    ),
    Icon(
      Icons.workspace_premium,
      color: Colors.green,
    ),
    Icon(
      Icons.admin_panel_settings_sharp,
      color: Colors.black,
    ),
    Icon(
      Icons.account_box,
      color: Colors.purple,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Select Any Day".text.xl3.make().p12(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: section.days!.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () => {
                          print("${section.sectionName}"),
                          print("${section.days![index].classes!}"),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Routine(
                                      classes: section.days![index].classes!)))
                        },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: iconList[index],
                          title: Text(section.days![index].dayName.toString()),
                        ),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
