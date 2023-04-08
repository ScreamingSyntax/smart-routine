// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:routine_app/models/sections.dart';

import 'days routine/day_detail.dart';

class HomePageContent extends StatelessWidget {
  final Section sec;
  const HomePageContent({
    Key? key,
    required this.sec,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
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
        sec.data == null
            ? Container(
                height: 500,
                color: Colors.transparent,
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                padding: EdgeInsets.all(30),
                height: 500,
                child: ListView.builder(
                  itemCount: sec.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () => {
                          print("${sec.data![index].sectionName!}"),
                          print("${sec.data}"),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DaysDetail(section: sec.data![index])))
                        },
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
                                  "${sec.data![index].sectionName}"
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
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }
}
