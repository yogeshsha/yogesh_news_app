import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';

import '../../constants/colors_constants.dart';

class PrimaryButtonComponent extends StatelessWidget {
  final Function onTap;
  final String title;
  final Color? backGroundColor;
  final Color? textColor;
  final bool allowBorder;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  const PrimaryButtonComponent({
    super.key,
    required this.title,
    this.allowBorder = false,
    this.backGroundColor,
    this.textColor,
    this.padding,
    this.alignment = Alignment.center,
    this.borderColor,
    required this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: () {
        onTap();
      },
      child: Container(
        // height: 50,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        decoration: BoxDecoration(
            color: backGroundColor ?? ColorsConstants.appColor,
            borderRadius: BorderRadius.circular(10),
            border: allowBorder
                ? Border.all(color: borderColor ?? ColorsConstants.appColor)
                : null),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
        alignment:alignment,
        child: TextAll(
            text: title,
            weight: FontWeight.w500,
            color: textColor ?? ColorsConstants.white,
            max: 16),
      ),
    );
  }
}
// class PrimaryButtonComponent2 extends StatelessWidget {
//   final Function onTap;
//   final String title;
//   final Color? backGroundColor;
//   final Color? textColor;
//   final bool allowBorder;
//   final Color? borderColor;
//   final EdgeInsetsGeometry? margin;
//
//   const PrimaryButtonComponent2({
//     super.key,
//     required this.title,
//     this.allowBorder = false,
//     this.backGroundColor,
//     this.textColor,
//     this.borderColor,
//     required this.onTap,
//     this.margin,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWellCustom(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//             color: backGroundColor ?? ColorsConstants.appColor,
//             borderRadius: BorderRadius.circular(10),
//             border: allowBorder
//                 ? Border.all(color: borderColor ?? ColorsConstants.appColor)
//                 : null),
//         margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
//         alignment: ,
//         child: TextAll(
//             text: title,
//             weight: FontWeight.w500,
//             color: textColor ?? ColorsConstants.white,
//             max: 16),
//       ),
//     );
//   }
// }
