import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
import '../../utils/app.dart';
import 'ink_well_custom.dart';

class PopUpMenuButtonComponent extends StatelessWidget {

  final Function(String) onSelectionChange;
  final Color? threeDotColor;
  final  List<DropdownMenuItem<String>> list;
  final String title;

  const PopUpMenuButtonComponent(
      {super.key,
      required this.onSelectionChange,
      this.threeDotColor , required this.list, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
        child: Icon(Icons.more_horiz_sharp,color: threeDotColor ?? ColorsConstants.dotsColor),
        onTap: () {
          if (list.isNotEmpty) {
            AppHelper.checkNewDropDown(
                context: context,
                list: list,
                onTap: (String value){
                  Future.delayed(const Duration(milliseconds: 500)).then((a) => onSelectionChange(value));
                },
                title: title,
                selected: null);
          }
        });
  }
}
