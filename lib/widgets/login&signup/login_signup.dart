import 'package:flutter/cupertino.dart';

// This is for the Heading of Both SignUp and Login
class HeadingContext extends StatelessWidget {
  const HeadingContext({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          // width: 150,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/iic.png",
            filterQuality: FilterQuality.high,
            scale: 4,

            // alignment: Alignment.topLeft,
            // fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}

//This is for the BottonContent
class BottomContent extends StatelessWidget {
  const BottomContent({super.key});
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/image 3.png",
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      );
}
