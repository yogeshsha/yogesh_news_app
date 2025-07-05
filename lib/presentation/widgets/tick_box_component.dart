import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';

import '../../constants/colors_constants.dart';

class TickBox extends StatelessWidget {
  final bool isTicked;
  final Function(bool)? onTap;
  final double? borderRadius;
  final double? height;
  final double? width;
  const TickBox({super.key, required this.isTicked, this.onTap, this.borderRadius, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap:(){
        if(onTap != null){
          onTap!(!isTicked);
        }
      },
      child: Container(
        height: height ?? 20,width:width ?? 20,
        decoration: BoxDecoration(
            color:isTicked ?ColorsConstants.appColor :Colors.transparent,
            border: Border.all(
                color:isTicked ?Colors.transparent
                    :Theme.of(context).colorScheme.onPrimary,width: 1),
            borderRadius: BorderRadius.circular(borderRadius ?? 5)
        ),
        child: Center(child: isTicked ?Icon(Icons.check,color: ColorsConstants.white,size: 16) :const SizedBox()),
      ),
    );
  }
}
