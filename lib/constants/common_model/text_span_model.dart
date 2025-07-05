import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_constants.dart';

class TextSpanModel{
  String title;
  bool textDynamic = false;
  TextStyle? style = GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.black
  );
  Function? onTap;
  TextAlign? textAlign;
  TextSpanModel({
    required this.title,
    this.textDynamic = false,
    this.style,
    this.textAlign,
    this.onTap
});
}