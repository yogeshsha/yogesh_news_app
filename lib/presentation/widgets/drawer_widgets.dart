import 'package:flutter/material.dart';

import '../../constants/colors_constants.dart';
Widget listTileWidget(String text,IconData icon,BuildContext context,{Function? onTap}){
  return Column(
    children: [
      ListTile(
        leading: Icon(icon,color: Theme.of(context).textTheme.displaySmall!.color,),
        title: Text(text,style: TextStyle(color: Theme.of(context).textTheme.displaySmall!.color)),
        onTap: () {
          if(onTap != null){
              onTap();
          }
        },
        trailing: Icon(Icons.keyboard_arrow_right_outlined,color: Theme.of(context).textTheme.displaySmall!.color,),
      ),
      dividerWidget(),

    ],
  );
}
Widget dividerWidget(){
  return Divider(color: ColorsConstants.drawerDividerColor,);
}