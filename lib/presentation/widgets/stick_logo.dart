import 'package:flutter/material.dart';
Widget logoStick({Function? onTap,double opacity = 0.5}){
  return Positioned(
      right: 10,
      top: 40,
      child: logo(onTap : onTap));
}
Widget logo({Function? onTap,double height = 40,double width  = 70,double opacity = 0.5}){
  return  InkWell(
    onTap: () {
      if(onTap != null){
        onTap();
      }
    },
    child: Opacity(
      opacity: opacity,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        // color: Colors.red,
        // child: const Text("Logo",style: TextStyle(),),
      ),
      // child: Image.asset(
      //   imagesConstants.logo2,
      //   width: width,
      //   height: height,
      //   fit: BoxFit.fill,
      // ),
    ),
  );
}