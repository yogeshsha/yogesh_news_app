import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
Widget mainText(String text){
  return Text(text,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),);
}

Widget boxTitleCategory(String text){
  return Container(
    height: 30,
    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    margin: const EdgeInsets.only(left: 25),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: ColorsConstants.boxColor
    ),
    child: Center(
      child: Text(text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black12),),
    ),
  );
}