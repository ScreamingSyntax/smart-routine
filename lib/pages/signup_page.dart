import 'package:flutter/material.dart';
import 'package:routine_app/widgets/login&signup/login_signup.dart';
import 'package:velocity_x/velocity_x.dart';

import '../routes/my_routes.dart';
import '../styles/text_form_field.dart';
import '../validation/my_validations.dart';
import 'login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String password1 = "";

  String password2 = "";

  FToast? fToast;

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    // name.addListener(() { })
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<bool> signUp(String name, String email, String password) async {
    print(name);
    print(email);
    print(password);
    try {
      Response response = await post(
          Uri.parse("https://hostingsyp.up.railway.app/api/users/"),
          headers: {"Content-Type": "application/json"},
          body:
              jsonEncode({"name": name, "email": email, "password": password}));
      if (response.statusCode == 200) {
        _showToast("Account Created Successfully");
        return true;
      }
      if (response.statusCode == 500) {
        _showToast("Email Already Exists");
      } else {
        _showToast("Failed To create an Account");
      }
    } catch (e) {
      _showToast("Server Issue");
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();
  void _validation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      bool check = await signUp(name.text, email.text, password.text);
      if (check) {
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }

  _showToast(String message) {
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
        gravity: ToastGravity.BOTTOM,
        fadeDuration: Duration(seconds: 0),
        toastDuration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          // padding: const EdgeInsets.all(20.0),
          constraints: const BoxConstraints.expand(),
          child: Column(
            // verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    "Sign Up"
                        .text
                        .color(Theme.of(context).colorScheme.onSecondary)
                        .bold
                        .xl5
                        .make(),
                    "Please Enter Valid Credentials"
                        .text
                        .textStyle(context.captionStyle)
                        .lg
                        .make(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textFields(context),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: _lowerPage(context),
              ),
              // const BottomContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFields(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              validator: (value) {
                NameValidation ac = NameValidation(
                    value: value,
                    validationType: "Name",
                    minLength: 4,
                    maxLength: 10);
                String? error = ac.empty();
                if (error != null) {
                  return _showToast(error);
                }
                error = ac.specialCharacters();
                if (error != null) {
                  return _showToast(error);
                }
                error = ac.fullNameValidation();
                if (error != null) {
                  return _showToast(error);
                }
                return null;
              },
              decoration: MyTextFormFieldDecoration(
                  hintText: "Enter Full Name",
                  iconData: Icons.person_2,
                  context: context),
            ),
            TextFormField(
              controller: email,
              validator: (value) {
                EmailValidation ac = EmailValidation(
                    value: value,
                    validationType: "Email",
                    minLength: 4,
                    maxLength: 50);
                String? error = ac.empty();
                if (error != null) {
                  return _showToast(error);
                }
                error = ac.domainValidation();
                if (error != null) {
                  return _showToast(error);
                }
                return null;
              },
              decoration: MyTextFormFieldDecoration(
                  hintText: "Enter Email Address",
                  iconData: Icons.mail,
                  context: context),
            ),
            TextFormField(
                controller: password,
                onChanged: (value) {
                  password1 = value;
                  setState(() {});
                },
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
                  error = ac.passwordSecurity();
                  if (error != null) {
                    return _showToast(error);
                  }
                  if (password2 != value) {
                    return _showToast(
                        "${ac.validationType} Field do not match");
                  }
                  return null;
                },
                obscureText: LoginPage.obscureText,
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
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.blue,
                      ),
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
                    ))),
            TextFormField(
              obscureText: LoginPage.obscureText,
              onChanged: (value) {
                password2 = value;
                setState(() {});
              },
              validator: (value) {
                PasswordValidation ac = PasswordValidation(
                    value: value,
                    validationType: "Password",
                    minLength: 7,
                    maxLength: 20);
                if (password1.toString() != value) {
                  _showToast("${ac.validationType} Field do not match");
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
  Widget _lowerPage(BuildContext context) => Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => _validation(context),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width /
                        0.001, // 80% of screen width
                    MediaQuery.of(context).size.height *
                        0.07, // // 8% of screen height
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Already Have an "
                    .text
                    .color(Theme.of(context).colorScheme.onSecondary)
                    .make(),
                " ".text.make(),
                "Account ?"
                    .text
                    .bold
                    .color(Theme.of(context).colorScheme.primary)
                    .make()
                    .onTap(() {
                  Navigator.pushNamed(context, MyRoutes.loginPage);
                })
              ],
            ),
          ],
        ),
      );
}
