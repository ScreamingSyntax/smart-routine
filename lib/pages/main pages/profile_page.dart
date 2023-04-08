import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:routine_app/controllers/local_storage.dart';
import 'package:routine_app/models/user.dart';

import 'package:routine_app/widgets/logOut.dart';
import 'package:velocity_x/velocity_x.dart';

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
  String? userEmail = "";

  getDatas(BuildContext context) async {
    userEmail = UserDetail.details[0].email;
    userName = UserDetail.details[0].name;
    userID = UserDetail.details[0].id;
    setState(() {});
  }

  @override
  void initState() {
    getDatas(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
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
                    color: Colors.white,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User ID :",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          hintText: "$userID",
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  pressedId = !pressedId;
                                });
                              },
                              onTapCancel: () {
                                setState(() {
                                  pressedId = !pressedId;
                                });
                              },
                              child: pressedId
                                  ? Icon(CupertinoIcons
                                      .square_arrow_up_on_square_fill)
                                  : Icon(Icons.edit))),
                      readOnly: pressedId ? true : false),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "User Name :",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: userName,
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              pressedName = !pressedName;
                            });
                          },
                          child: pressedName
                              ? Icon(CupertinoIcons.person_crop_circle)
                              : Icon(Icons.edit)),
                    ),
                    initialValue: "$userName",
                    readOnly: pressedName ? true : false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "User Email :",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: userEmail,
                        suffixIcon: InkWell(
                            onTap: () => setState(() {
                                  pressedEmail = !pressedEmail;
                                }),
                            child: pressedEmail
                                ? Icon(CupertinoIcons.mail)
                                : Icon(Icons.edit))),
                    readOnly: pressedEmail ? true : false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: null, child: Text("Update Profile")),
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
          ],
        ),
      ),
    );
  }
}
