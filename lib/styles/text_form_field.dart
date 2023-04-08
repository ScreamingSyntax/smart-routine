import 'package:flutter/material.dart';

class MyTextFormFieldDecoration extends InputDecoration {
  MyTextFormFieldDecoration({
    required String hintText,
    required IconData iconData,
    required BuildContext context,
    IconData? suffixIcon,
  }) : super(
            // isDense: true,
            fillColor: Theme.of(context).cardColor,
            prefixIcon: Icon(
              iconData,
            ),
            hintText: hintText,
            helperText: " ",
            suffixIcon: suffixIcon != null ? (Icon(suffixIcon)) : null,
            filled: true,
            // errorText: "Nae Nigga",
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 2),
            ));
}
