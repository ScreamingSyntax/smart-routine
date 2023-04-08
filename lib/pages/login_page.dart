// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:routine_app/pages/home_page.dart';
import 'package:routine_app/pages/signup_page.dart';
import 'package:routine_app/widgets/CircularMessage.dart';
import 'package:routine_app/widgets/dialogBox.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/auth_controller.dart';

import '../styles/text_form_field.dart';
import '../validation/my_validations.dart';
import '../widgets/PopScope.dart';
import '../widgets/login&signup/login_signup.dart';

class LoginPage extends StatefulWidget {
  static bool obscureText = true;
  LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authController = AuthController();
  String text = "Successfully Logged in";
  // bool pressedOn = false;
  // bool loggedIn = false;
  // final storage = new FlutterSecureStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  bool netWorkAction = false;

  var focusedField = true;
  final _formKey = GlobalKey<FormState>();
  void _validation(BuildContext context) async {
    // await Future.delayed(Duration(seconds: 1));
    if (_formKey.currentState!.validate()) {
      setState(() {
        netWorkAction = true;
      });
      String message = await authController.login(email.text, password.text);

      if (message == "Login Successfully") {
        setState(() {
          netWorkAction = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        showErrorMessage(context,
            message: message, errorType: "Verification Issue");
        setState(() {
          netWorkAction = false;
        });
      }
    }
  }

  Widget circularMessage(String message) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(message), Text(""), CircularProgressIndicator()],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return netWorkAction
        ? MyCircularProgressBar(context, "Verifying Credentials")
        : WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Container(
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      HeadingContext(),
                      Container(
                        child: Column(
                          children: [
                            "Login"
                                .text
                                .color(
                                    Theme.of(context).colorScheme.onSecondary)
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
                    showErrorMessage(context,
                        message: error, errorType: "Validation Error");
                    return "";
                  }
                  error = bc.domainValidation();
                  if (error != null) {
                    showErrorMessage(context,
                        message: error, errorType: "Validation Error");
                    return "";
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
              validator: (value) {
                PasswordValidation ac = PasswordValidation(
                  value: value,
                  validationType: "Password",
                  minLength: 7,
                  maxLength: 20,
                );
                String? error = ac.empty();
                if (error != null) {
                  // _showToast(error);
                  showErrorMessage(context,
                      message: error, errorType: "Validation Error");
                  return "";
                }
                error = ac.length();
                if (error != null) {
                  // _showToast(error);
                  showErrorMessage(context,
                      message: error, errorType: "Validation Error");
                  return "";
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
            onPressed: () async {
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
                Navigator.push((context),
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              })
            ],
          ),
        ],
      );
}
