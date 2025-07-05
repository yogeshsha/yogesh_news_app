import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import 'ink_well_custom.dart';

class ShareChatComponent extends StatelessWidget {
  final Color backGroundColor;
  final String image;
  final Function onTap;
  final String name;

  const ShareChatComponent(
      {super.key,
      required this.backGroundColor,
      required this.image,
      required this.name,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.width / 3,
            decoration:BoxDecoration( color: backGroundColor,borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: SvgPicture.asset(image),
            ),
          ),
          const SizedBox(height: 5),
          TextAll(
              text: name,
              weight: FontWeight.w500,
              color: Colors.green,
              max: 12)
        ],
      ),
    );
  }
}
