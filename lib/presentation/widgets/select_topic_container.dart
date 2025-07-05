import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

import '../../constants/colors_constants.dart';
import 'ink_well_custom.dart';

class SelectTopicContainer extends StatelessWidget {
  final bool isSelect;
  final String title ;
  final Function() onSelect;
  const SelectTopicContainer({super.key, required this.isSelect, required this.onSelect, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
          color: ColorsConstants.textGrayColorLightOne,
          borderRadius: const BorderRadius.all(Radius.circular(6))
      ),
      child: InkWellCustom(
        onTap: (){
          onSelect();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 2,color:isSelect ?ColorsConstants.appColor :ColorsConstants.textGrayColor),
                  shape: BoxShape.circle
              ),
              child:isSelect
                  ? Center(child: Icon(Icons.circle_rounded,size: 14,color: ColorsConstants.appColor))
                  :const SizedBox() ,),


            SimpleText(text: title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,fontSize: 12,color: ColorsConstants.textGrayColor),),
          ],
        ),
      ),
    );
  }
}
