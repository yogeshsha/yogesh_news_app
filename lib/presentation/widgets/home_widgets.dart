import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
Widget text1(String text,BuildContext context){
  return Text(text,style: const TextStyle(color: Colors.white60,fontSize: 12,),);
}
Widget text2(String text){
  return Text(text,maxLines: 4,overflow: TextOverflow.ellipsis,style: const TextStyle(color: Color(0xffEAEAEA),fontSize: 14),);
}
Widget text3(String text,BuildContext context){
  return Text(text,textAlign: TextAlign.center,style: const TextStyle(color: Color(0xffFDFDFD) ,fontSize: 22),);
}
Widget text4(String text){
  return Text(text,style: TextStyle(color: ColorsConstants.logoColor,fontSize: 18),);
}