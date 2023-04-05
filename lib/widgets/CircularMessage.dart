import 'package:flutter/material.dart';

Widget MyCircularProgressBar(BuildContext context, String message) {
  return Material(
      child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(message), Text(""), CircularProgressIndicator()],
    ),
  ));
}
