import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/colors_constants.dart';
import '../../constants/images_constants.dart';
import 'ink_well_custom.dart';

class FloatingButtonWidget extends StatelessWidget {
  final Function onTap;
  const FloatingButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      bottom: 16,right: 16,
      child: InkWellCustom(
        onTap: () {
       onTap();
        },
        child: Container(
          height:56,width: 56,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:ColorsConstants.appColor,
            boxShadow: [
              BoxShadow(
              color: ColorsConstants.textGrayColor,
              blurRadius: 10,
              blurStyle: BlurStyle.normal,
              spreadRadius:-1,
              offset: const Offset(1,4,),

            )]
          ),

            child: Icon(Icons.add,color: ColorsConstants.white),
        ),
      ),
    );
  }
}

class FloatingHomeWidget extends StatelessWidget {
  final Function onTap;
  final int count;
  final ValueKey reloadKey;
  const FloatingHomeWidget({super.key, required this.onTap, required this.count, required this.reloadKey});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      bottom: 16,right: 16,
      child: Stack(
        children: [
          InkWellCustom(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: const EdgeInsets.all(13),
              height:56,width: 56,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:ColorsConstants.appColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorsConstants.textGrayColor,
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      spreadRadius:-1,
                      offset: const Offset(1,4),

                    )]
              ),

              child: SvgPicture.asset(ImagesConstants.homeChat,),
            ),
          ),
          // Positioned(
          //     right: 0,
          //     top: 0,
          //     child: CountComponent(reloadKey: reloadKey,count: count)),
        ],
      ),
    );
  }
}