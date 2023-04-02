// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:routine_app/pages/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/auth_controller.dart';
import '../routes/my_routes.dart';
import '../styles/text_form_field.dart';
import '../validation/my_validations.dart';
import '../widgets/login&signup/login_signup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  static bool obscureText = true;
  LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // AuthController authController = AuthController();
  String text = "Successfully Logged in";
  FToast? fToast;
  bool loggedIn = false;
  final storage = new FlutterSecureStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login(String email, String password) async {
    try {
      Response response = await post(
          Uri.parse("https://hostingsyp.up.railway.app/api/users/login"),
          body: jsonEncode({"email": email, "password": password}),
          headers: {"Content-Type": "application/json"});

      var one = json.decode(response.body);
      if (response.statusCode == 200) {
        if (one["success"] == 1) {
          _showToast(one["message"], gravity: ToastGravity.TOP);
          final storage = new FlutterSecureStorage();
          await storage.write(key: "token", value: one["token"]);
          setState(() {
            loggedIn = true;
          });
          setState(() {
            text = "Login Successfull";
          });
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            text = "Fetching data....";
          });
          await Future.delayed(Duration(seconds: 3));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            loggedIn = false;
          });
          setState(() {
            text = "Fetching data....";
          });
        }
        if (one["success"] == 0) {
          _showToast(one['data']);
        }
      }
    }

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> output = json.decode(response.body);
    //   if (output["success"] == 0) {
    //     _showToast(output["message"]);
    //   }
    //   if (output["success"] == 1) {
    //     _showToast(output["message"]);
    //   }
    // }
    catch (e) {
      print(e);
      _showToast("Server Issue");
    }
  }

  void initState() {
    // name.addListener(() { })
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  late String? _onchanged = "";
  var focusedField = true;
  final _formKey = GlobalKey<FormState>();
  void _validation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      login(email.text, password.text);
      // authController.loginUser(email.text, password.text, context);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
    }
  }

  _showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        // border: Border.all(color: Colors.blue),
        color: Colors.black54,
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
    fToast?.showToast(
        child: toast,
        gravity: gravity,
        fadeDuration: Duration(seconds: 0),
        toastDuration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn
        ? Scaffold(
            body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 10,
              ),
              Text(text)
            ],
          ))
        : Scaffold(
            resizeToAvoidBottomInset: true,
            // backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                constraints: BoxConstraints.expand(),
                // padding: const EdgeInsets.all(20.0),
                child: Column(
                  // verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    HeadingContext(),
                    Container(
                      // padding: EdgeInsets.all(30),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Login"
                              .text
                              .color(Theme.of(context).colorScheme.onSecondary)
                              .bold
                              .xl5
                              .make(),
                          "Please Sign in to Continue"
                              .text
                              .textStyle(context.captionStyle)
                              .lg
                              .make(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          _form(context),
                          _lowerContent(context),
                        ],
                      ),
                    ),
                    BottomContent()
                  ],
                ),
              ),
            ),
          );
  }

  Widget _form(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: email,
                validator: (value) {
                  EmailValidation bc = EmailValidation(
                      value: value,
                      validationType: "Email",
                      minLength: 4,
                      maxLength: 50);
                  String? error = bc.empty();
                  if (error != null) {
                    return _showToast(error);
                  }
                  error = bc.domainValidation();
                  if (error != null) {
                    return _showToast(error);
                  }
                  return null;
                },
                decoration: MyTextFormFieldDecoration(
                    hintText: "Enter College Email",
                    iconData: Icons.people_outline_rounded,
                    context: context)),
            TextFormField(
              controller: password,
              obscureText: LoginPage.obscureText,
              // onTap: () => setState(() => focusedField = false),
              // onTapOutside: (event) => setState(() => focusedField = false),
              validator: (value) {
                PasswordValidation ac = PasswordValidation(
                  value: value,
                  validationType: "Password",
                  minLength: 7,
                  maxLength: 20,
                );
                String? error = ac.empty();
                if (error != null) {
                  return _showToast(error);
                }
                error = ac.length();
                if (error != null) {
                  return _showToast(error);
                }
                return null;
              },
              decoration: InputDecoration(
                  // isDense: true,
                  fillColor: Theme.of(context).cardColor,
                  prefixIcon: Icon(
                    Icons.password,
                  ),
                  hintText: "Enter Password",
                  helperText: " ",
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      LoginPage.obscureText = !LoginPage.obscureText;
                      setState(() {});
                    },
                  ),
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
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 2),
                  )),
            ),
          ],
        ),
      );

  Widget _lowerContent(BuildContext context) => Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              return _validation(context);
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width /
                      0.001, // 80% of screen width
                  MediaQuery.of(context).size.height *
                      0.07, // 8% of screen height
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(
              "LOGIN",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Dont Have An"
                  .text
                  .color(Theme.of(context).colorScheme.onSecondary)
                  .make(),
              " ".text.make(),
              "Account ?"
                  .text
                  .semiBold
                  .color(Theme.of(context).colorScheme.primary)
                  .make()
                  .onTap(() {
                Navigator.pushNamed(context, MyRoutes.signUpPage);
              })
            ],
          ),
        ],
      );
}
