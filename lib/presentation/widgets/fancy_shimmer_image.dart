import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../constants/images_constants.dart';

Widget fancyShimmerImageWidget(String? url, {BorderRadius radius = BorderRadius.zero}){
  if(url == null){
    return ClipRRect(
       borderRadius: radius,
        child: Image.asset(ImagesConstants.placeHolderImage,fit: BoxFit.fill,));
  }else {
    return FancyShimmerImage(
      imageUrl: url,
      boxFit: BoxFit.fill,
      // shimmerBaseColor: randomColor(),
      // shimmerHighlightColor: randomColor(),
      // shimmerBackColor: randomColor(),

      imageBuilder: (context, imageProvider) {
        return ClipRRect(
            borderRadius: radius,
            child: Image.network(url, fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(ImagesConstants.placeHolderImage);
              },)
        );
      },
      errorWidget: Image.asset(ImagesConstants.placeHolderImage),
    );
  }
}