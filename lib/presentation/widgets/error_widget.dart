import 'package:flutter/material.dart';

Widget errorWidget(BuildContext context,String message){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/2,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
        color: Colors.red.shade700
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.warning_amber_outlined,size: 90,color: Colors.white,),
          const SizedBox(height: 10,),
          const Text("Something Went Wrong",style: TextStyle(color: Colors.white,fontSize: 22),),
          const SizedBox(height: 20,)  ,
          Text(message,style: const TextStyle(color: Colors.white,fontSize: 14),),
          const SizedBox(height: 20,)
        ],
      )
  );
}