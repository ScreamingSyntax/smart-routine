import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> showErrorMessage(BuildContext context,
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
              color: Colors.red,
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
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.red,
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
