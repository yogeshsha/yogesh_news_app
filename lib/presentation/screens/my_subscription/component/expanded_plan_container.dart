import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/colors_constants.dart';
import '../../../../constants/common_model/text_span_model.dart';
import '../../../widgets/ink_well_custom.dart';
import '../../../widgets/primary_button_component.dart';
import '../../../widgets/rich_text.dart';
import '../../../widgets/text_common.dart';

class ExpandedPlanContainer extends StatelessWidget {
  final ExpandableController controller;
  final String planTitle;
  final String planOffer;
  final String planAmount;
  final Function(bool) openDetail;
  final bool check;
  final bool checkToChangeColor;
  final String description;
  final Function onGetStart;
  final String? buttonName;

  const ExpandedPlanContainer(
      {super.key,
      required this.planTitle,
      required this.planOffer,
      required this.planAmount,
      required this.openDetail,
      required this.controller,
      required this.check,
      required this.onGetStart,
      required this.description,
      this.buttonName,
      required this.checkToChangeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TextAll(
                      align: TextAlign.start,
                      text: planTitle,
                      weight: FontWeight.w500,
                      color: checkToChangeColor
                          ? check
                              ? Theme.of(context).colorScheme.primary
                              : ColorsConstants.white
                          : Theme.of(context).colorScheme.primary,
                      max: 14)),
              Container(
                  decoration: BoxDecoration(
                      color: checkToChangeColor
                          ? check
                              ? Theme.of(context).secondaryHeaderColor
                              : ColorsConstants.white
                          : ColorsConstants.appColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: TextAll(
                        text: planOffer,
                        weight: FontWeight.w500,
                        color: checkToChangeColor
                            ? check
                                ? Theme.of(context).colorScheme.onTertiary
                                : ColorsConstants.appColor
                            : ColorsConstants.white,
                        max: 14),
                  ))
            ],
          ),
          RichTextComponent2(list: [
            TextSpanModel(
                title: planAmount,
                style: GoogleFonts.crimsonText(
                    color: checkToChangeColor
                        ? check
                            ? Theme.of(context).colorScheme.primary
                            : ColorsConstants.white
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 40)),
            TextSpanModel(
                title: "/Month",
                style: GoogleFonts.crimsonText(
                    color: checkToChangeColor
                        ? check
                            ? Theme.of(context).colorScheme.primary
                            : ColorsConstants.white
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 20))
          ]),
          RichTextComponent2(list: [
            TextSpanModel(
                title: description,
                style: GoogleFonts.poppins(
                    color: checkToChangeColor
                        ? check
                            ? ColorsConstants.textGrayColor
                            : ColorsConstants.white
                        : ColorsConstants.textGrayColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12)),
          ]),
          PrimaryButtonComponent(
              backGroundColor: checkToChangeColor
                  ? check
                      ? Theme.of(context).secondaryHeaderColor
                      : ColorsConstants.white
                  : Theme.of(context).secondaryHeaderColor,
              textColor: checkToChangeColor
                  ? check
                      ? Theme.of(context).colorScheme.onTertiary
                      : ColorsConstants.appColor
                  : Theme.of(context).colorScheme.onTertiary,
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              title: buttonName ?? "Get Started",
              onTap: () {
                onGetStart();
              }),
          InkWellCustom(
            onTap: () {
              openDetail(!controller.value);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: checkToChangeColor
                          ? check
                              ? ColorsConstants.textGrayColorLightThree
                              : ColorsConstants.white
                          : ColorsConstants.textGrayColorLightThree),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextAll(
                      text: !check ? "Hide Details" : "View Details",
                      weight: FontWeight.w500,
                      color: checkToChangeColor
                          ? check
                              ? ColorsConstants.textGrayColor
                              : ColorsConstants.white
                          : ColorsConstants.textGrayColor,
                      max: 14),
                  const SizedBox(width: 10),
                  Icon(
                    !check
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down_outlined,
                    color: checkToChangeColor
                        ? check
                            ? ColorsConstants.textGrayColor
                            : ColorsConstants.white
                        : ColorsConstants.textGrayColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
