import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

class SelectedComponent extends StatelessWidget {
  final bool isSelected;
  final String title;

  final AlignmentGeometry? alignment;
  final double? curve;
  final Function? onTap;
  final EdgeInsets? padding;
  const SelectedComponent(
      {super.key, this.isSelected = false, required this.title, this.padding, this.onTap, this.curve, this.alignment});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: (){
        if(onTap != null){
          onTap!();
        }
      },
      child: Container(
        padding:padding ?? const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected
            ? ColorsConstants.appColor
            :  Theme.of(context).colorScheme.onSecondaryContainer,
            borderRadius: BorderRadius.circular(curve ?? 25),
            border: Border.all(
                color: isSelected
                    ? ColorsConstants.appColor
                    : Theme.of(context).colorScheme.onSurface)),
        alignment: alignment,
        child: SimpleText(
            text: title,
            size: 12,
            weight: FontWeight.w500,
            color: isSelected
                ? ColorsConstants.white
                : ColorsConstants.textGrayColor),
      ),
    );
  }
}
