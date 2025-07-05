import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';

import '../../constants/colors_constants.dart';
import '../../constants/images_constants.dart';

class Loading extends StatelessWidget {
  final Color? color;

  const Loading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: color ?? Colors.black.withOpacity(0.2),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesConstants.load),
              // const CustomCircularLoader(),
              const SizedBox(
                height: 5,
              ),
              TextAll(
                  textDynamic: true,
                  text: "Fetching...",
                  weight: FontWeight.w600,
                  color: ColorsConstants.white,
                  max: 18)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCircularLoader extends StatefulWidget {
  final double? height;
  final double? width;
  const CustomCircularLoader({super.key, this.height, this.width});

  @override
  State<CustomCircularLoader> createState() => _CustomCircularLoaderState();
}

class _CustomCircularLoaderState extends State<CustomCircularLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _scaleAnimation = Tween<double>(begin: 0, end: 1.2).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.height ??  80,
      width:widget.width ?? 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsConstants.white,
      ),
      padding: const EdgeInsets.all(4),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: List.generate(8, (index) {
              final angle = index * 45.0;
              return Transform.rotate(
                angle: angle * 3.14159 / 180,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Transform(
                      transform: Matrix4.identity()..translate(10.0),
                      child: SvgPicture.string(
                        '<svg xmlns="http://www.w3.org/2000/svg" width="10" height="20"><rect x="0" y="0" width="10" height="20" rx="2" ry="2" fill="#6E53F1"/></svg>',
                        width: 10,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
      // child: Stack(
      //   children: [
      //     Positioned(
      //       top: 0,
      //         left: 0,
      //         right: 0,
      //         bottom: 0,
      //         child: CircularProgressIndicator(color: ColorsConstants.appColor,strokeWidth: 3 )),
      //     // Padding(
      //     //   padding: const EdgeInsets.all(5),
      //     //   child: Container(
      //     //     decoration: BoxDecoration(
      //     //       shape: BoxShape.circle,
      //     //       image: DecorationImage(
      //     //         image:  AssetImage(
      //     //           ImagesConstants.replaceImage,
      //     //         )
      //     //       )
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
