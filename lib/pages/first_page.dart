import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routine_app/pages/login_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/PopScope.dart';

// ignore: must_be_immutable
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late CarouselController _buttonCarouselController;

  final List<String> _images = const [
    "assets/images/sliders/0.png",
    "assets/images/sliders/1.png",
    "assets/images/sliders/2.png",
    "assets/images/sliders/3.png",
    "assets/images/sliders/4.png",
  ];
  int _imageCount = 0;
  @override
  void initState() {
    super.initState();
    _buttonCarouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _imageSlider(context),
              _textBottom(context),
              _indicatorSlider(context),
              _bottomButtons(context),
              const SizedBox() //This is for bottom space while we do the fucking space between
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageSlider(BuildContext context) => CarouselSlider.builder(
        carouselController: _buttonCarouselController,
        itemCount: _images.length,
        itemBuilder: (context, index, realIndex) {
          final imagesIndex = _images[index];
          return Image.asset(
            imagesIndex,
            fit: BoxFit.cover,
          );
        },
        options: CarouselOptions(
            height: 500,
            // enlargeCenterPage: true,
            // animateToClosest: true,
            enlargeCenterPage: true,
            autoPlay: true,
            enableInfiniteScroll: true,
            // pageSnapping: true,
            enlargeFactor: 0.5,
            autoPlayCurve: Curves.easeInCirc,
            onPageChanged: (index, reason) =>
                setState((() => _imageCount = index)),
            viewportFraction: 1),
      );

  Widget _textBottom(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Quality Course\nAcross The Globe".text.xl4.extraBlack.make(),
            "London Metropolitan University, commonly known as London Met, is a public research university in London, England. The University of North London and London Guildhall University merged in 2002 to create the university. The University's roots go back to 1848."
                .text
                .textStyle(context.captionStyle)
                .make(),
          ],
        ),
      );
  Widget _indicatorSlider(BuildContext context) => AnimatedSmoothIndicator(
      activeIndex: _imageCount,
      count: _images.length,
      effect: const SlideEffect(
          spacing: 5.0,
          radius: 1,
          dotWidth: 50.0,
          dotHeight: 3.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          dotColor: Color(0xffC4C4C4),
          activeDotColor: Color(0xff605F5F)));

  Widget _bottomButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => _buttonCarouselController.previousPage(),
            style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xffE0E6F3)),
              foregroundColor: const MaterialStatePropertyAll(Colors.black),
              fixedSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width *
                      0.4, // 80% of screen width
                  MediaQuery.of(context).size.height *
                      0.04, // 8% of screen height
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(
              "Back",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage())),
            style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll(Color(0xff4DC591)),
              fixedSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width *
                      0.4, // 80% of screen width
                  MediaQuery.of(context).size.height *
                      0.04, // 8% of screen height
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontFamily: GoogleFonts.redHatDisplay().fontFamily),
            ),
          ),
        ],
      );
}
