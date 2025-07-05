import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import '../../widgets/custome_dote_indicator.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int _currentImageIndex = 0;
  final CarouselSliderController imageController = CarouselSliderController();
  final CarouselSliderController textController = CarouselSliderController();

  List<Widget> setSliderImage(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    List<Widget> slideImage = [
      Container(
          alignment: Alignment.bottomCenter,
          height: mediaHeight * .52,
          child: Image.asset(ImagesConstants.splashFirst)),
      Container(
          alignment: Alignment.bottomCenter,
          height: mediaHeight * .52,
          child: Image.asset(ImagesConstants.splashSecond)),
      Container(
          alignment: Alignment.bottomCenter,
          height: mediaHeight * .52,
          child: Image.asset(ImagesConstants.splashThree)),
    ];
    return slideImage;
  }

  List<Widget> setSliderText() {
    List<Widget> slideText = [
      Padding(
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: Column(
          children: [
            SimpleText(
              alignment: TextAlign.center,
              text: "Stay Informed from all over the World!",
              style: GoogleFonts.crimsonText(
                  fontWeight: FontWeight.w700, fontSize: 25,color: Theme.of(context).colorScheme.primary),
            ),
            const SimpleText(
              alignment: TextAlign.center,
              text:
                  "Breaking news alerts straight to your phone! Stay in the know with our app's instant updates.",
              size: 11,
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: Column(
          children: [
            SimpleText(
              alignment: TextAlign.center,
              text: "Get the Latest Updates of Our INDIA!",
              style: GoogleFonts.crimsonText(
                  fontWeight: FontWeight.w700, fontSize: 25,color: Theme.of(context).colorScheme.primary),
            ),
            const SimpleText(
              alignment: TextAlign.center,
              text:
                  "Stay connected to India and beyond. Explore breaking news, trends, and stories with our user-friendly app.",
              size: 11,
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 45, right: 45),
        child: Column(
          children: [
            SimpleText(
              alignment: TextAlign.center,
              text: "Stay Informed, Anytime Anywhere!",
              style: GoogleFonts.crimsonText(
                  fontWeight: FontWeight.w700, fontSize: 25,color: Theme.of(context).colorScheme.primary),
            ),
            const SimpleText(
              alignment: TextAlign.center,
              text:
                  "Experience the pulse of the world, from politics to pop culture. Dive into comprehensive coverage,all within our intuitive news app.",
              size: 11,
            )
          ],
        ),
      ),
    ];
    return slideText;
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          width: mediaWidth,
          height: mediaHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CarouselSlider(
                  carouselController: imageController,
                  items: setSliderImage(context),
                  options: CarouselOptions(
                    reverse: false,
                    aspectRatio: 1 / 0.9,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    pauseAutoPlayOnTouch: true,
                    onPageChanged: (index, reason) {
                      _currentImageIndex = index;
                      imageController.jumpToPage(_currentImageIndex);
                      textController.jumpToPage(_currentImageIndex);
                      setState(() {});
                    },
                  ),
                ),
              ),
              Container(
                  width: mediaWidth,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CarouselSlider(
                        carouselController: textController,
                        items: setSliderText(),
                        options: CarouselOptions(
                          reverse: false,
                          aspectRatio: .55 / 0.2,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            _currentImageIndex = index;
                            textController.jumpToPage(_currentImageIndex);
                            imageController.jumpToPage(_currentImageIndex);
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CustomDotsIndicator(
                          dotsCount: setSliderText().length,
                          currentPosition: _currentImageIndex,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryButtonComponent(
                          onTap: () {
                            Navigator.pushNamed(context, "/signUp");
                          },
                          title: "Get Started"),
                      const SizedBox(height: 10),
                      PrimaryButtonComponent(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        title: "Login",
                        backGroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
