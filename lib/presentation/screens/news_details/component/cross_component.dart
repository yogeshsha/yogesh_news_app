import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
class CrossComponent extends StatelessWidget {
  final Function onTap;
  const CrossComponent({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: onTap,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor ,
        ),
        child: Icon(
          Icons.close,
          color:Theme.of(context).colorScheme.secondary ,
          size: 18,
        ),
      ),
    );
  }
}
