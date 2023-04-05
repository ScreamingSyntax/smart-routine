import 'package:flutter/material.dart';

Future<bool> showExitPopup(
    BuildContext context, String message, String errorType) async {
  return await showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text(errorType),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: Text("Try again"),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}
