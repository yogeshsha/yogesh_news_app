import 'package:flutter/material.dart';

class InkWellCustom extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Function? onLongPress;

  const InkWellCustom(
      {super.key, required this.onTap, required this.child, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onTap();
          });
        },
        onLongPress: () {
          if (onLongPress != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onLongPress!();
            });
          }
        },
        child: child,
      ),
    );
  }
}
