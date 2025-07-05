import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import '../../constants/colors_constants.dart';
import '../../utils/app.dart';
import 'ink_well_custom.dart';

class DropDownWidget extends StatelessWidget {
  final String? initialValue;
  final List<DropdownMenuItem<String>> items;
  final Function(String) onChange;
  final String hint;
  final bool compulsory;
  final double radius;
  final double width;
  final double widthBetweenTextAndArrow;
  final bool enableBorder;
  final bool isRightAlign;
  final bool isExpanded;
  final EdgeInsets padding;
  final Color? iconColor;
  final Color? dropdownColor;
  final bool? hintDynamic;
  final Widget? suffix;
  final String initialHint;

  const DropDownWidget(
      {super.key,
      required this.initialValue,
      required this.items,
      required this.onChange,
      required this.hint,
      this.hintDynamic ,
      this.suffix ,
      this.compulsory = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      this.radius = 25,
      this.width = 20,
      this.widthBetweenTextAndArrow = 10,
      this.enableBorder = true,
      this.isExpanded = true,
      this.iconColor,
      this.dropdownColor,
      this.isRightAlign = false, required this.initialHint});

  @override
  Widget build(BuildContext context) {
    Widget textWidget = SimpleText(text: initialHint,
        style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w400));
    if (items.isNotEmpty) {
      if (initialValue != null) {
        for (int i = 0; i < items.length; i++) {
          if (items[i].value == initialValue.toString()) {
            textWidget = items[i].child;
            break;
          }
        }
      } else {
        textWidget =SimpleText(text: hint,
            style: GoogleFonts.poppins(
                color:Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w400));
      }
    }
    return InkWellCustom(
      onTap: () {
        if (items.isNotEmpty) {
          AppHelper.checkNewDropDown(
              context: context,
              list: items,
              onTap: onChange,
              title: hint,
              selected: initialValue);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
                color: enableBorder
                    ? Theme.of(context).colorScheme.surface
                    : Colors.transparent),
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isExpanded
                  ? Expanded(
                      child: Align(
                          alignment: isRightAlign
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: textWidget))
                  : Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 100),
                      child: textWidget),
              suffix ?? const SizedBox(),
              SizedBox(width: widthBetweenTextAndArrow),
              Icon(
                Icons.keyboard_arrow_down_sharp,size: 25,
                color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.8),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TempDropDownWidget extends StatelessWidget {
  final String? initialValue;
  final List<DropdownMenuItem<String>> items;
  final Function(String) onChange;
  final String hint;
  final bool compulsory;
  final double radius;
  final bool enableBorder;
  final bool isExpanded;
  final EdgeInsets padding;
  final Color? iconColor;
  final Color? dropdownColor;
  final TextEditingController controller;

  const TempDropDownWidget(
      {super.key,
      required this.initialValue,
      required this.items,
      required this.onChange,
      required this.hint,
      this.compulsory = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 10),
      this.radius = 25,
      this.enableBorder = true,
      this.isExpanded = true,
      this.iconColor,
      this.dropdownColor,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.transparent),
      child: items.isNotEmpty
          ? DropdownButton<String>(
              value: initialValue,
              onChanged: (String? value) {},
              items: items,
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: enableBorder
                          ? ColorsConstants.textGrayColor.withOpacity(.2)
                          : Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    TextAll(
                        align: TextAlign.center,
                        textDynamic: true,
                        text:
                            "hint${compulsory ? "*" : ""}",
                        weight: FontWeight.w400,
                        color: ColorsConstants.skipColor,
                        max: 14),
                    const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: ColorsConstants.skipColor,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
