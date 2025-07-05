import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/images_constants.dart';

class DismissibleComponent extends StatelessWidget {
  final Widget child;
  final Function onDismissed;

  const DismissibleComponent(
      {super.key,
      required this.child,
      required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (DismissDirection direction) {
        onDismissed();
      },
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        width: 100,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFFB05858),
            Color(0xFFE86868),
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(ImagesConstants.trashSvg),
        ),
      ),
      child: child
    );
  }
}
