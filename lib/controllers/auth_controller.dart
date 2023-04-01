import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthController {
  Future loginUser(String email, String password, BuildContext context) async {
    final _url = "https://hostingsyp.up.railway.app/api/users/login";
    Response response = await post(
        Uri.parse("https://hostingsyp.up.railway.app/api/users/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var loginArr = response.body;
    } else {
      print("Error");
    }
  }

  void setState(Null Function() param0) {}
}
