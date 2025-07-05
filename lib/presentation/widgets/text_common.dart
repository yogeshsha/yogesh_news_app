import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/utils/app.dart';

class TextAll extends StatelessWidget {
  final String text;
  final double max;
  final int maxLine;
  final Color color;
  final FontWeight weight;
  final bool textDynamic;
  final bool underLine;
  final TextOverflow? overflow;
  final TextAlign align;

  const TextAll(
      {super.key,
      required this.text,
      required this.weight,
      required this.color,
      required this.max,
      this.maxLine = 1,
      this.textDynamic = false,
      this.underLine = false,
      this.align = TextAlign.center,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      AppHelper.getDynamicString(context, text),

      // text,
      // textDynamic
      //     ? text
      //     : AppHelper.language[text] ?? AppHelper.defaultLanguage[text] ?? text,
      softWrap: true,
      maxLines: maxLine,
      minFontSize: 1,
      maxFontSize: max + AppHelper.getFontSize(),
      textAlign: align,
      overflow: overflow,
      style: GoogleFonts.poppins(
          fontWeight: weight,
          fontSize: max + AppHelper.getFontSize(),
          color: color,
          decoration: underLine ? TextDecoration.underline : null,
          decorationColor: color),
    );
  }
}
