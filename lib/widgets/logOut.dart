import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routine_app/pages/first_page.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

Future<bool> showLogout(BuildContext context,
    {required String message, required String errorType}) async {
  return await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        useRootNavigator: true,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            errorType,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            message,
            // textAlign: TextAlign.center,
            style: GoogleFonts.redHatDisplay(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => {
                storage.deleteAll(),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FirstPage()))
              },
              child: Text(
                'LogOut',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
