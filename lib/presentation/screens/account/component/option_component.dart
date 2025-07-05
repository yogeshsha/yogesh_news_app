import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import '../../../../constants/colors_constants.dart';
import '../../../widgets/text_common.dart';

class OptionComponent extends StatelessWidget {
  final String optionTitle;
  final String? svgImage;
  final String? pngImage;
  final Function onTap;
  final bool showContainer;
  final Color? imageColor;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;

  const OptionComponent({super.key,
    required this.optionTitle,
    this.svgImage,
    required this.onTap, this.pngImage, this.showContainer = false, this.imageColor, this.containerPadding, this.containerMargin});

  @override
  Widget build(BuildContext context) {

    return InkWellCustom(
      onTap: (){
        onTap();
      },
      child: Container(
        margin: containerMargin??const EdgeInsets.all(0),
        padding:containerPadding?? const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color:showContainer ?ColorsConstants.textGrayColorLightTwo :Colors.transparent)
        ),
        child: Row(
          children: [

            if(svgImage != null)
            SvgPicture.asset(svgImage!),
            if(pngImage != null)
              Image.asset(pngImage!),
            const SizedBox(width: 10),
            Expanded(child: TextAll(
                align: TextAlign.start,text: optionTitle,
                weight: FontWeight.w500, color: Theme.of(context).colorScheme.onPrimary, max: 14)),
            SizedBox(
              height: 30,
              width: 30,
                child: Center(child: Icon(Icons.arrow_forward_ios_rounded,size: 18,color:ColorsConstants.textGrayColor,)))
        
          ],
        ),
      ),
    );
  }
}
