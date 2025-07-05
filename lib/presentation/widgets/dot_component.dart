import 'package:flutter/material.dart';

class DotComponent extends StatelessWidget {
  final double? size;
  final Color? color;

  const DotComponent({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.circle_rounded,
        color: color ?? Theme.of(context).colorScheme.secondary,
        size: size ?? 8);
    //   Container(
    //   height:height ?? 10,
    //   width:width ?? 10,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     color:color ?? ColorsConstants.descriptionColor
    //   ),
    // );
  }
}
