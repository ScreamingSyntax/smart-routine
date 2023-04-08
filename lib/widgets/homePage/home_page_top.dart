import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageTop extends StatelessWidget {
  final firstName;

  const HomePageTop({super.key, required this.firstName});
  @override
  Widget build(BuildContext context) {
    return VxArc(
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
                  "Hello ".text.fontWeight(FontWeight.bold).size(20).make(),
                  "${firstName}"
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
        ));
  }
}
