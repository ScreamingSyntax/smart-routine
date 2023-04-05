// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// class AuthController {
//   Future loginUser(String email, String password, BuildContext context) async {
//     final _url = "https://hostingsyp.up.railway.app/api/users/login";
//     Response response = await post(
//         Uri.parse("https://hostingsyp.up.railway.app/api/users/login"),
//         body: jsonEncode({"email": email, "password": password}),
//         headers: {"Content-Type": "application/json"});
//     if (response.statusCode == 200) {
//       var loginArr = response.body;
//       print(loginArr);
//     } else {
//       print("Error");
//     }
//   }

//   void setState(Null Function() param0) {}
// }

import 'dart:convert';

import 'package:http/http.dart';
import 'package:routine_app/controllers/local_storage.dart';

class AuthController {
  LocalStorage storage = LocalStorage();
  Future<String> login(String email, String password) async {
    try {
      Response response = await post(
          Uri.parse(
              "https://aaryansyproutineapplication.azurewebsites.net/api/users/login"),
          body: jsonEncode({"email": email, "password": password}),
          headers: {"Content-Type": "application/json"});

      var one = json.decode(response.body);
      storage.writeToStorage('email', one["email"]);
      // await storage.write(key: 'email', value: one["email"]);
      if (response.statusCode == 200) {
        if (one["success"] == 1) {
          storage.writeToStorage('token', one['token']);
          return one["message"];
          // await Future.delayed(Duration(seconds: 1));
          // await Future.delayed(Duration(seconds: 3));
          // await Future.delayed(Duration(seconds: 2));
        }
        if (one["success"] == 0) {
          return one['data'];
        }
      } else {
        return "Server Issue";
      }
      return "Something went Wrong";
    } catch (e) {
      print(e);
      return "Server Issue";
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    print(name);
    print(email);
    print(password);
    try {
      Response response = await post(
          Uri.parse(
              "https://aaryansyproutineapplication.azurewebsites.net/api/users/"),
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode({"name": name, "email": email, "password": password}));
      if (response.statusCode == 200) {
        print("Account Created Successfully");
        return true;
      }
      if (response.statusCode == 500) {
        print("Email Already Exists");
      } else {
        print("Failed To create an Account");
      }
    } catch (e) {
      print(e);
      print("Server Issue");
    }
    return false;
  }
}
