import 'package:flutter/material.dart';

Widget MyCircularProgressBar(BuildContext context, String message,
    {Color color = Colors.white, foreGroundColor = Colors.black}) {
  return Material(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(color: foreGroundColor),
            ),
            Text(""),
            CircularProgressIndicator(
              color: foreGroundColor,
            )
          ],
        ),
      ));
}
