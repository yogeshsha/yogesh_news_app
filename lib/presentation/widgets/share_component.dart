import 'package:flutter/material.dart';
import 'ink_well_custom.dart';
class ShareComponent extends StatelessWidget {
  final Function onTapShare;
  const ShareComponent({super.key, required this.onTapShare});

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: onTapShare,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:  Theme.of(context).colorScheme.onBackground,
        ),
        padding: const EdgeInsets.all(10),
        child:Icon(Icons.share,color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
