import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> showErrorMessage(BuildContext context,
    {required String message, required String errorType}) async {
  return await showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
        context: context,
        useRootNavigator: true,
        builder: (context) => AlertDialog(
          title: Text(
            errorType,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          icon: Icon(
            Icons.account_circle_outlined,
            color: Colors.red,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.redHatDisplay().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 15),
          elevation: 10,
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
