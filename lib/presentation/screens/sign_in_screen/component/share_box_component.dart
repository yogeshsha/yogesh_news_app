import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/constants/images_constants.dart';

import '../../../../constants/colors_constants.dart';

class ShareBox extends StatelessWidget {
  final Icon? icon;
  final SvgPicture? svgImage;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  const ShareBox({super.key, this.icon, this.svgImage, this.height, this.width, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin?? const EdgeInsets.all(5),
      height:height?? 50,
      width:width?? 50,
      decoration: BoxDecoration(
          border: Border.all(color: ColorsConstants.textGrayColor),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: icon ??svgImage ?? SvgPicture.asset(ImagesConstants.redHart)),
    );
  }
}
