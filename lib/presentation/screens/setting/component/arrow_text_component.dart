import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

class ArrowTextComponent extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;

  final Function onTap;
  const ArrowTextComponent({super.key, required this.title, this.titleStyle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: SimpleText(
              text: title,
              style: titleStyle ??
                  GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorsConstants.titleColor),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,color: ColorsConstants.arrowColorSetting,
            size: 16,
          )
        ],
      ),
    );
  }
}
