import 'package:flutter/material.dart';

import '../../constants/colors_constants.dart';

class CustomDotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int currentPosition;

  const CustomDotsIndicator(
      {Key? key, required this.dotsCount, required this.currentPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotsCount, (index) {
        if (index == currentPosition) {
          return Container(
              margin: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorsConstants.appColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child:
              Container(
                height: 7,
                width: 10,
                decoration: BoxDecoration(
                    color: ColorsConstants.appColor
                ),
              )
            // AutoSizeText(
            //   maxLines: 1,
            //   minFontSize: 5,
            //   maxFontSize: 7,
            //   softWrap: true,
            //   "${currentPosition + 1}/$dotsCount",
            //   style: GoogleFonts.poppins(
            //       color: Colors.white,
            //       fontSize: 7,
            //       fontWeight: FontWeight.w500),
            // ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          );
        }
      }),
    );
  }
}