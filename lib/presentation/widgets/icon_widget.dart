import 'package:flutter/material.dart';
Widget iconTapWidget(String image,Function onTap){
  return GestureDetector(
    onTap: (){
      onTap();
    },
      child: Image.asset(image,fit: BoxFit.fill,width: 35,height: 35,)
  );
}