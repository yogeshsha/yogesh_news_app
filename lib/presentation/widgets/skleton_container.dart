import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonContainer extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Duration animationDuration;


  const SkeletonContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,

    this.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  State<SkeletonContainer> createState() => _SkeletonContainerState();
}

class _SkeletonContainerState extends State<SkeletonContainer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsConstants.shimmerColor1,
      highlightColor: ColorsConstants.shimmerColor2,
      direction: ShimmerDirection.ltr,
      child: Container(
        width:  widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          // color: Colors.grey[300],
          color: ColorsConstants.shimmerColor2,
          borderRadius: widget.borderRadius,
        ),
      ),
    );
  }
}
