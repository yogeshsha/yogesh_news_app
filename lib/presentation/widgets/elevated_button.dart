import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';


class CustomElevatedButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final double? curveBorder;

  const CustomElevatedButton(
      {super.key, required this.text, required this.onPressed, this.style, this.buttonColor, this.curveBorder});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:buttonColor?? ColorsConstants.appColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(curveBorder??12.0), // Button border radius
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0), // But
        // ton padding
      ),
      onPressed: onPressed,
      child: SimpleText(text:text,style:style?? GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14,color: ColorsConstants.black),),
    );
  }
}

class CustomElevatedButton2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? textColor;
  final double textSize;
  final FontWeight? textFontWeight;
  final double curve;

  final BorderSide side;
  final bool textDynamic;

  const CustomElevatedButton2(
      {super.key,
        this.textDynamic = false,
        required this.textColor,
        required this.backgroundColor,
        required this.text,
        required this.onPressed,
        this.padding =const EdgeInsets.symmetric(horizontal: 60.0, vertical: 12.0),
        this.curve = 25,
        this.textFontWeight = FontWeight.w600,
        this.textSize = 18,
        this.side = BorderSide.none});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(curve), // Button border radius
            side: side),
        padding: padding, // Button padding
      ),
      onPressed: onPressed,
      child: AutoSizeText(
        text,
        softWrap: true,
        maxLines: 1,
        minFontSize: textSize - 9,
        maxFontSize: textSize,
        style: GoogleFonts.poppins(
            color: textColor, fontSize: textSize, fontWeight: textFontWeight),
      ),
    );
  }
}
class BottomContainerWithShadow extends StatelessWidget {
  final Widget child;
  const BottomContainerWithShadow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration:  BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            color: ColorsConstants.white,
            boxShadow:const [ BoxShadow(
                color: Colors.black12,
                spreadRadius: 3,
                blurRadius: 40
            )]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: child ,
      ),
    );
  }
}
