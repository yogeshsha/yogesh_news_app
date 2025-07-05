import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_constant.dart';
import '../../../../constants/colors_constants.dart';
import '../../../../constants/images_constants.dart';
import '../../../widgets/ink_well_custom.dart';
class BookMarkComponent extends StatelessWidget {
  final Function onTapIsBookMark;
  final bool isBookMarked;
  final double? curve;
  const BookMarkComponent({super.key, required this.onTapIsBookMark, required this.isBookMarked, this.curve});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: onTapIsBookMark,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(curve ?? 10),
          color: isBookMarked
              ? ColorsConstants.appColor
              : Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          ImagesConstants.savedSvg,
          colorFilter: AppConstant.getColorFilter(isBookMarked
              ? ColorsConstants.white
              : ColorsConstants.unSelect),
          height: 18,
        ),
      ),
    );
  }
}
class BookMarkComponent2 extends StatelessWidget {
  final Function onTapIsBookMark;
  final bool isBookMarked;
  final double? curve;
  const BookMarkComponent2({super.key, required this.onTapIsBookMark, required this.isBookMarked, this.curve});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: onTapIsBookMark,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isBookMarked
              ? ColorsConstants.appColor
              :  Theme.of(context).colorScheme.onBackground,
        ),
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          ImagesConstants.savedSvg,
          colorFilter: AppConstant.getColorFilter(isBookMarked
              ? ColorsConstants.white
              : Theme.of(context).colorScheme.secondary),
          height: 18,
        ),
      ),
    );
  }
}
