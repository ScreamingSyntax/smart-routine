import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routine_app/controllers/auth_controller.dart';

import 'package:routine_app/controllers/local_storage.dart';
import 'package:routine_app/main.dart';
import 'package:routine_app/models/user.dart';

import 'package:routine_app/widgets/logOut.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../validation/my_validations.dart';
import '../../widgets/dialogBox.dart';

class ProfilePageeMain extends StatefulWidget {
  @override
  State<ProfilePageeMain> createState() => _ProfilePageeMainState();
}

class _ProfilePageeMainState extends State<ProfilePageeMain> {
  // FlutterSecureStorage storage = FlutterSecureStorage();
  LocalStorage storage = LocalStorage();
  bool pressedId = true;
  bool pressedName = true;
  bool pressedEmail = true;
  int userID = 0;
  String? userName = "";
  late Future<bool> updated;
  String? userEmail = "";
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  bool EditPressed = true;
  AuthController ac = AuthController();

  getDatas(BuildContext context) async {
    userEmail = await UserDetail.details[0].email;
    userName = await UserDetail.details[0].name;
    userID = await UserDetail.details[0].id;
    setState(() {});
  }

  @override
  void initState() {
    getDatas(context);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  void _validation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // ac.upDate(context, userID, name.text, email.text);
      if (name.text == "" && email.text == "") {
        showErrorMessage(context,
            message: "You didn't specify any edit",
            errorType: "Validation Error");
      } else if (name.text == "") {
        ac.upDate(context, userID, userName!, email.text);
      } else if (email.text == "") {
        ac.upDate(context, userID, name.text, userEmail!);
      } else {
        print("dd");
        ac.upDate(context, userID, name.text, email.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.cyan,
      backgroundColor:
          MyApp.lightThemeData ? Colors.cyanAccent : Color(0xff28282B),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              // fit: ,/
              alignment: Alignment.center,
              children: [
                VxArc(
                  height: 29,
                  child: Container(
                    color: MyApp.lightThemeData ? Colors.white : Colors.black,
                    padding: EdgeInsets.all(140),
                  ),
                  arcType: VxArcType.CONVEX,
                ),
                Positioned(
                    top: 90,
                    child: Text(
                      "User Profile Section",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 25,
                          color: MyApp.lightThemeData
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                Positioned(
                  top: 150,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.09,
                        ),
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 0.1,
                              blurStyle: BlurStyle.solid,
                              spreadRadius: 1)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        200,
                      ),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 100,
                          child: Icon(
                            Icons.people,
                            size: 100,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 90),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "User Name :",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color:
                            MyApp.lightThemeData ? Colors.black : Colors.white,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        NameValidation ac = NameValidation(
                            value: value,
                            validationType: "Name",
                            minLength: 4,
                            maxLength: 10);
                        String? error = ac.empty();
                        if (error != null) {
                          // showErrorMessage(context,
                          //     message:
                          //         "Please edit name as well or fill the same name if you don't want to update",
                          //     errorType: "Not A Error Actually");
                          return null;
                        }
                        error = ac.specialCharacters();
                        if (error != null) {
                          showErrorMessage(context,
                              message: error, errorType: "Validation Error");
                          return " ";
                        }
                        error = ac.fullNameValidation();
                        if (error != null) {
                          showErrorMessage(context,
                              message: error, errorType: "Validation Error");
                          return " ";
                        }
                        return null;
                      },
                      controller: name,
                      decoration: InputDecoration(
                        hintText: userName,
                        hintStyle: TextStyle(
                          color:
                              MyApp.lightThemeData ? Colors.blue : Colors.white,
                        ),
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                pressedName = !pressedName;
                              });
                            },
                            child: pressedName
                                ? Icon(
                                    CupertinoIcons.person_crop_circle,
                                    color: MyApp.lightThemeData
                                        ? Colors.blue
                                        : Colors.white,
                                  )
                                : Icon(
                                    Icons.edit,
                                    color: MyApp.lightThemeData
                                        ? Colors.blue
                                        : Colors.white,
                                  )),
                      ),
                      // initialValue: "$userName",
                      style: TextStyle(
                        color:
                            MyApp.lightThemeData ? Colors.blue : Colors.white,
                      ),
                      readOnly: pressedName ? true : false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "User Email :",
                      style: TextStyle(
                        color:
                            MyApp.lightThemeData ? Colors.blue : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        EmailValidation ac = EmailValidation(
                            value: value,
                            validationType: "Email",
                            minLength: 4,
                            maxLength: 50);
                        String? error = ac.empty();
                        if (error != null) {
                          return null;
                        }
                        error = ac.domainValidation();
                        if (error != null) {
                          showErrorMessage(context,
                              message: error, errorType: "Validation Error");
                          return " ";
                        }
                        return null;
                      },
                      controller: email,
                      style: TextStyle(
                        color:
                            MyApp.lightThemeData ? Colors.blue : Colors.white,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: MyApp.lightThemeData
                                ? Colors.blue
                                : Colors.white,
                          ),
                          hintText: userEmail,
                          suffixIcon: InkWell(
                              onTap: () => setState(() {
                                    pressedEmail = !pressedEmail;
                                  }),
                              child: pressedEmail
                                  ? Icon(
                                      CupertinoIcons.mail,
                                      color: MyApp.lightThemeData
                                          ? Colors.blue
                                          : Colors.white,
                                    )
                                  : Icon(
                                      Icons.edit,
                                      color: MyApp.lightThemeData
                                          ? Colors.blue
                                          : Colors.white,
                                    ))),
                      readOnly: pressedEmail ? true : false,
                      // initialValue: "${userEmail}",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              print(name.text);
                              print(email.text);
                              return _validation(context);
                            },
                            child: Text("Update Profile")),
                        ElevatedButton(
                            onPressed: () async {
                              showLogout(context,
                                  message: "Are you sure you want to logout?",
                                  errorType: "Confirmation");
                            },
                            child: Text("Log Out"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
