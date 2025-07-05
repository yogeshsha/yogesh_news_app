import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/fancy_shimmer_image.dart';
import '../../widgets/detail_screen_widget.dart';

// ignore: must_be_immutable
class DetailsImageTemplate extends StatelessWidget {
  String image;
  String text;

  DetailsImageTemplate({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          fancyShimmerImageWidget(image),

          Positioned(
              bottom: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boxTitleCategory("Health"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: mainText(text)),
                ],
              )),
        ],
      ),
    );
  }
}
