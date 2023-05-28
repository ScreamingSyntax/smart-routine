import 'package:flutter/material.dart';
import 'package:routine_app/pages/login_page.dart';

// comment


import '../widgets/background1.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image:
                FirstPageBackImage(imageData: "assets/images/first_page1.png"),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "The key is not to prioritize what's on your schedule, but to schedule your priorities.”\n ~ Stephen Covey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const BottomContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomContent extends StatelessWidget {
  const BottomContent({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            )),
        style: ButtonStyle(
            // backgroundColor: const MaterialStatePropertyAll(Color(0xff403b58)),
            fixedSize: const MaterialStatePropertyAll(Size(330, 100)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: Text(
          "Lets Go",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1),
        ));
  }
}
