import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final TextAlign? alignment;
  final TextStyle? style;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const SimpleText({
    super.key,
    this.alignment,
    required this.text,
    this.style,
    this.size,
    this.weight,
    this.color,
    this.textOverflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {

    return Text(
      textAlign: alignment ?? TextAlign.left,
      overflow: textOverflow,
      maxLines: maxLines,

        String.fromCharCodes(AppHelper.getDynamicString(context,text).runes.toList()),
        // AppHelper.getDynamicString(context, text),
      // String.fromCharCodes((Runes(AppHelper.getDynamicString(context, text)))),
      style: style ??
          GoogleFonts.poppins(
              fontSize: (size ?? 14) + AppHelper.getFontSize(),
              fontWeight: weight ?? FontWeight.w400,
              color: color ?? Theme.of(context).colorScheme.secondary),
    );
  }
}
