import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/utils/app.dart';
import '../../constants/common_model/text_span_model.dart';

class RichTextComponent extends StatelessWidget {
  final String text1;
  final double fontSizeCommon;
  final FontWeight fontWeight1;
  final Color color1;
  final bool underline1;
  final String text2;
  final FontWeight fontWeight2;
  final Color color2;
  final bool underline2;
  final String text3;
  final FontWeight fontWeight3;
  final Color color3;
  final bool underline3;

  const RichTextComponent({
    super.key,
    required this.text1,
    this.fontSizeCommon = 12,
    this.fontWeight1 = FontWeight.w400,
    this.color1 = Colors.black,
    this.underline1 = false,
    required this.text2,
    this.fontWeight2 = FontWeight.w400,
    this.color2 = Colors.black,
    this.underline2 = false,
    required this.text3,
    this.fontWeight3 = FontWeight.w400,
    this.color3 = Colors.black,
    this.underline3 = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: GoogleFonts.poppins(
          fontSize: fontSizeCommon,
          fontWeight: fontWeight1,
          color: color1,
          decoration:
              underline1 ? TextDecoration.underline : TextDecoration.none,
        ),
        children: <TextSpan>[
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {},
              text: text2,
              style: GoogleFonts.poppins(
                fontWeight: fontWeight2,
                decoration:
                    underline2 ? TextDecoration.underline : TextDecoration.none,
                color: color2,
              )),
          TextSpan(
              text: text3,
              style: GoogleFonts.poppins(
                fontSize: fontSizeCommon,
                fontWeight: fontWeight3,
                color: color3,
                decoration:
                    underline3 ? TextDecoration.underline : TextDecoration.none,
              )),
        ],
      ),
    );
  }
}

class RichTextComponent3 extends StatelessWidget {
  final String text1;
  final double fontSizeCommon;
  final FontWeight fontWeight1;
  final Color color1;
  final bool underline1;
  final String text2;
  final FontWeight fontWeight2;
  final Color color2;
  final bool underline2;
  final String text3;
  final FontWeight fontWeight3;
  final Color color3;
  final bool underline3;
  final Function? onTapText2;

  const RichTextComponent3({
    super.key,
    required this.text1,
    this.fontSizeCommon = 12,
    this.fontWeight1 = FontWeight.w400,
    this.color1 = Colors.black,
    this.onTapText2,
    this.underline1 = false,
    required this.text2,
    this.fontWeight2 = FontWeight.w400,
    this.color2 = Colors.black,
    this.underline2 = false,
    required this.text3,
    this.fontWeight3 = FontWeight.w400,
    this.color3 = Colors.black,
    this.underline3 = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: GoogleFonts.poppins(
          fontSize: fontSizeCommon,
          fontWeight: fontWeight1,
          color: color1,
          decoration:
              underline1 ? TextDecoration.underline : TextDecoration.none,
        ),
        children: <TextSpan>[
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (onTapText2 != null) {
                    onTapText2!();
                  }
                },
              text: text2,
              style: GoogleFonts.poppins(
                fontWeight: fontWeight2,
                decoration:
                    underline2 ? TextDecoration.underline : TextDecoration.none,
                color: color2,
              )),
          TextSpan(
              text: (text3),
              style: GoogleFonts.poppins(
                fontSize: fontSizeCommon,
                fontWeight: fontWeight3,
                color: color3,
                decoration:
                    underline3 ? TextDecoration.underline : TextDecoration.none,
              )),
        ],
      ),
    );
  }
}

class RichTextComponent2 extends StatelessWidget {
  final List<TextSpanModel> list;
  final TextAlign? textAlign;

  const RichTextComponent2({super.key, required this.list, this.textAlign});

  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      List<TextSpanModel> tempList = [...list];
      tempList.removeAt(0);
      return Text.rich(
        textAlign: textAlign ?? TextAlign.left,
        TextSpan(
          text: list[0].textDynamic
              ? list[0].title
              : AppHelper.getDynamicString(context, list[0].title),
          style: list[0].style,
          children: tempList
              .map((e) => TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (e.onTap != null) {
                        e.onTap!();
                      }
                    },
                  text: e.textDynamic
                      ? e.title
                      : AppHelper.getDynamicString(context, e.title),
                  style: e.style))
              .toList(),
        ),
      );
    }

    return const SizedBox();
  }
}
