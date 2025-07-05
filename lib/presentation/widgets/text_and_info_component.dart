import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import '../../constants/colors_constants.dart';
import '../../constants/images_constants.dart';
import '../../utils/app.dart';
import 'elevated_button.dart';
import 'ink_well_custom.dart';

class TextAndInfoComponent extends StatelessWidget {
  final String title;
  final Function? onTap;
  final bool isCompulsory;
  final EdgeInsets padding;
  final bool isExpanded;
  final bool textDynamic;
  final FontWeight fontWeight;
  final FontWeight? textFontWeight;
  final Color? color;
  final bool isTextAll;
  final double fontSize;
  final bool toolTip;

  const TextAndInfoComponent({super.key,
    this.textDynamic = false,
    this.isCompulsory = false,
    this.isExpanded = true,
    this.isTextAll = true,
    this.fontSize = 14,
    required this.title,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.fontWeight = FontWeight.w400,
    this.textFontWeight = FontWeight.w400,
    this.color = Colors.black, this.toolTip=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: isExpanded
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          isExpanded ? Expanded(child: returnText()) : returnText(),
          toolTip
          ?Tooltip(
            decoration: BoxDecoration(
                color:ColorsConstants.appColor,
                borderRadius:BorderRadius.circular(15)),
            textStyle: GoogleFonts.poppins(
                color: ColorsConstants.white),
            preferBelow: false,
            triggerMode: TooltipTriggerMode.tap,
            showDuration: const Duration(seconds: 1),
            waitDuration:const Duration(milliseconds: 1),
            message: textDynamic ? title : title,
            child: SvgPicture.asset(ImagesConstants.infoSvg),
          )
          :InkWellCustom(onTap: () {
              if (onTap != null) {
                onTap!();
              } else {
                AppHelper.bottomSheet(

                    context: context,
                    title: title,
                    bottom: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomElevatedButton(
                            text: "Close",
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ),
                    center: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled Lorem Ipsum is simply dummy text of the printing and typesetting industry.\n\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: ColorsConstants.filterBackgroundColor),
                      ),
                    ));
              }
            },
            child: SvgPicture.asset(ImagesConstants.infoSvg),
          )
        ],
      ),
    );
  }

  Widget returnText() {
    if (isTextAll) {
      return TextAll(
          align: TextAlign.start,
          textDynamic: true,
          text:"${textDynamic ? title :
              title}${isCompulsory ? "*" : ""}",
          weight: fontWeight,
          color: color ?? ColorsConstants.skipColor,
          max: fontSize);
    } else {
      return Text("${textDynamic ? title :
          title}${isCompulsory ? "*" : ""}",textAlign: TextAlign.left, style: GoogleFonts.poppins(fontSize: fontSize,

        fontWeight: fontWeight, color: color ?? ColorsConstants.skipColor));
    }
  }
}

