import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class DottedAxisLineComponent extends StatelessWidget {
  final Color color;
  final Axis axis;
  final double length;
  final double dashLength;
  final double? dashBorderRadius;
  final double? dashGap;
  final double? dashThickness;

  const DottedAxisLineComponent({super.key,
    required this.color,
    required this.axis,
    required this.length,
    required this.dashLength,
    this.dashBorderRadius, this.dashGap, this.dashThickness});

  @override
  Widget build(BuildContext context) {
    return Dash(
      direction: axis,
      length: length,
      dashLength: dashLength,
      dashColor: color,
      dashBorderRadius:dashBorderRadius??2,
      dashGap:dashGap??5 ,
      dashThickness: dashThickness??1.5,
    );
  }
}


