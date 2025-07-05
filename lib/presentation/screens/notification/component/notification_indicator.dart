import 'package:flutter/material.dart';

import '../../../../constants/colors_constants.dart';
import '../../../widgets/text_common.dart';
class NotificationIndicator extends StatelessWidget {
  final int number;
  const NotificationIndicator({super.key,required this.number});

  @override
  Widget build(BuildContext context) {
    if(number > 0){
      return  Container(
        decoration: BoxDecoration(
          color: ColorsConstants.appColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
        child: TextAll(text: number.toString(), weight: FontWeight.w600, color: ColorsConstants.white, max: 13,textDynamic: true),
      );
    }

    return const SizedBox();
  }
}
