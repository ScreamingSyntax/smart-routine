import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:routine_app/controllers/local_storage.dart';
import 'package:routine_app/widgets/dialogBox.dart';

import '../models/user.dart';

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
      print(one);
      // await storage.write(key: 'email', value: one["email"]);
      if (response.statusCode == 200) {
        if (one["success"] == 1) {
          storage.writeToStorage('email', one["email"]);
          storage.writeToStorage('token', one['token']);
          return one["message"];
        }
        if (one["success"] == 0) {
          return one['data'];
        }
      }
      return "Something went Wrong";
    } catch (e) {
      print(e);
      return "Server Issue";
    }
  }

  Future<bool> signUp(
      BuildContext context, String name, String email, String password) async {
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
        showErrorMessage(context,
            message: "Email Already Exists", errorType: "Verification Issue");
        print("Email Already Exists");
      } else {
        showErrorMessage(context,
            message: "Failed To create an Account", errorType: "Verification");
        print("Failed To create an Account");
      }
    } catch (e) {
      print(e);
      showErrorMessage(context,
          message: "Server Issue", errorType: "Verification");
      print("Server Issue");
    }
    return false;
  }

  Future<bool> upDate(
      BuildContext context, int id, String name, String email) async {
    print(id);
    print(name);
    print(email);
    try {
      Response response = await patch(
        Uri.parse(
            "https://aaryansyproutineapplication.azurewebsites.net/api/users/update/"),
        headers: {
          'Authorization':
              'Barear ${await storage.readFromStorage('token') as String}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({"id": id, "name": name, "email": email}),
      );
      if (response.statusCode == 200) {
        var toMap = jsonDecode(response.body);
        if (toMap["success"] == 1) {
          return showErrorMessage(context,
              message: toMap["data"], errorType: "Existing Mail");

























              
        }
        showErrorMessage(context,
            message: "Successfully Changed", errorType: "Success");
        storage.writeToStorage('id', id.toString());
        storage.writeToStorage('username', name);
        storage.writeToStorage('email', email);
        UserDetail.details.clear();
        UserDetail.details.add(User(id: id, name: name, email: email));
      }
    } catch (e) {
      showErrorMessage(context,
          message: "Something Went Wrong", errorType: "Server Issue");
    }
    return false;
  }
}
