import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:velocity_x/velocity_x.dart";

class MyThemes {
  static Color bluishColor = const Color(0xff403b58);
  static Color blue = const Color(0xff7266F6);
  static Color creamishColor = const Color(0xffE4F0FE);
  static Color darkCreamColor = Vx.gray900;
  static Color lightBluishColor = Vx.indigo500;
  static lightTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff1E26E9), //For Buttons
          // ignore: use_full_hex_values_for_flutter_colors
          onPrimary: creamishColor, //For Text On Buttons
          secondary: creamishColor,
          onSecondary: Vx.gray900, //For Most Fonts
          error: Colors.redAccent,
          onError: Colors.red,
          background: Colors.yellow,
          onBackground: Vx.gray900,
          surface: Colors.white, //For Back
          onSurface: const Color(0xff403b58),
          //For Text on the Surface
        ),
        iconTheme: IconThemeData(color: Colors.amber),
        cardColor:
            creamishColor, // I'll use this for cards, containers and text form field fill color
        scaffoldBackgroundColor: Colors.white, //For Background Colors
      );
  static darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.white,
          // ignore: use_full_hex_values_for_flutter_colors
          onPrimary: Colors.black,
          secondary: creamishColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.red,
          background: Colors.white,
          onBackground: Vx.gray900,
          surface: Colors.greenAccent,
          onSurface: Colors.blueGrey),
      cardColor: bluishColor,
      iconTheme: IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: Color(0xff28282B));
}
