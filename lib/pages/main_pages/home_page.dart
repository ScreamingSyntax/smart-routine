import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageMain extends StatelessWidget {
  HomePageMain({super.key});
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
                            "Hello Sundhya"
                                .text
                                .fontWeight(FontWeight.bold)
                                .size(20)
                                .make(),
                            "Good Night!"
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
