import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/stick_logo.dart';

import 'arrow_back_ios.dart';

PreferredSizeWidget appBarWithBackLogoCenterImage(BuildContext context,String title){
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Stack(
      children: [
        AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leadingWidth: 90,
          toolbarHeight: 60,
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 7,),
                  arrowBack(context),
                  const Spacer(flex: 1),
                  Text(title,style: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color,fontWeight: FontWeight.bold,fontSize: 18),),
                  const Spacer(flex: 2),
                  // const SizedBox()
                ],
              ),
            ),


            // SizedBox(width: MediaQuery.of(context).size.width/2.8,),
          ],
        ),
        logoStick(onTap: (){
          Navigator.pop(context);
        })
      ],
    ),
  );
}