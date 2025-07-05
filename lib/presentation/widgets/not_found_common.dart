import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import '../../constants/images_constants.dart';

class NotFoundCommon extends StatelessWidget {
  final String text;
  final String? buttonText;
  final String? fullButtonText;
  final String? fullText;
  final String? title;
  final String? subTitle;
  final String? buttonFullTitle;
  final bool textDynamic;
  final bool showButton;
  final Function? onTap;
  final double bottomSizedBoxHeight;

  const NotFoundCommon(
      {super.key,
      this.text = "",
      this.fullText,
      this.textDynamic = false,
      this.onTap,
      this.fullButtonText,
      this.showButton = true,
      this.bottomSizedBoxHeight = 60,
      this.buttonText, this.title, this.subTitle, this.buttonFullTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height/3
          ),
          child: SvgPicture.asset(
            ImagesConstants.noResultFoundSvg,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: SimpleText(text:title ?? "No Results Found",
              size: 26,
              alignment: TextAlign.center,
              weight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ),
        if((subTitle ?? "").isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: SimpleText(text:subTitle ?? "",
                size: 12,
                weight: FontWeight.w400,
                color: ColorsConstants.descriptionColor
            ),
          ),
        ),
        if (showButton)
          const SizedBox(
            height: 20,
          ),
        if (showButton)
          PrimaryButtonComponent(onTap: (){
            if (onTap != null) {
              onTap!();
            }
          }, title:buttonFullTitle ?? "Add ${buttonText ?? text}"),
        SizedBox(height: bottomSizedBoxHeight)
      ],
    );
  }
}


