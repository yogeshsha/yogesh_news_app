import 'package:flutter/material.dart';

import '../../../../constants/colors_constants.dart';
import '../../../widgets/ink_well_custom.dart';
import '../../../widgets/text_common.dart';

class LanguageComponent extends StatelessWidget {
  final String title;
  final bool isTicked;
  final Function onTap;
  const LanguageComponent({super.key, required this.onTap, required this.isTicked, required this.title});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return  InkWellCustom(
      onTap: (){
        onTap();
      },
      child: Container(
        height: mediaWidth*.43,
        width:  mediaWidth*.43,
        decoration: BoxDecoration(
            border: Border.all(color:isTicked ?ColorsConstants.appColor :Theme.of(context).colorScheme.onPrimary,width: 1),
            borderRadius: BorderRadius.circular(22)
        ),child: Center(
          child: TextAll(text: title, weight: FontWeight.w400,color:isTicked ?ColorsConstants.appColor
              :Theme.of(context).colorScheme.onPrimary, max: 25),
        ),
      ),
    );
  }
}
