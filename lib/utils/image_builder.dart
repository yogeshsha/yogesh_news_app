import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utils/app.dart';

import '../constants/colors_constants.dart';

class ImageBuilder {
  static Widget imageBuilder4(String url,
      {double height = 54,
      double width = 54,
      EdgeInsets padding = EdgeInsets.zero,
      BoxBorder? border,
      double? curve,
      double? paddingAll,
      bool createBaseUrl = true,
      Widget? showReplaceWidget}) {
    bool checkUrl = AppHelper.isValidUrl(url, createBaseUrl: createBaseUrl);

    String sendUrl = createBaseUrl ? AppHelper.createImageBaseUrl(url) : url;

    // print(SessionHelper().get(SessionHelper.imageBaseUrl) ?? "");
    // print(sendUrl);
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(curve ?? 15),
          color: ColorsConstants.backgroundColor,
          border: border),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(curve ?? 15),
        child:
            url.isNotEmpty && checkUrl
            // true
                ? CachedNetworkImage(
                    imageUrl: sendUrl,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            // const ShimmerComponent(),
                            Transform.scale(
                      scale: 0.3,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: ColorsConstants.appColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        showReplaceWidget ??
                        Padding(
                          padding: EdgeInsets.all(paddingAll ?? 16),
                          child: Icon(Icons.person,
                              color: ColorsConstants.appColor, size: 16),
                        ),
                  )
                : showReplaceWidget ??
                    Padding(
                      padding: EdgeInsets.all(paddingAll ?? 16),
                      child: Icon(Icons.person,
                          color: ColorsConstants.appColor, size: 16),
                    ),
      ),
    );
  }

  static Widget imageBuilderWithoutContainer(String url,
      {double? curve,
      double? paddingAll,
      bool createBaseUrl = true,
      double? height,
      double? width,
      Widget? showReplaceWidget}) {
    createBaseUrl = false; //Has to Remove Later

    bool checkUrl = AppHelper.isValidUrl(url, createBaseUrl: createBaseUrl);

    String sendUrl = createBaseUrl ? AppHelper.createImageBaseUrl(url) : url;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(curve ?? 15),
          color: ColorsConstants.backgroundColor),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(curve ?? 15),
        child:
            url.isNotEmpty && checkUrl
            // true
                ? CachedNetworkImage(
                    imageUrl: sendUrl,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            // const ShimmerComponent(),
                            Transform.scale(
                      scale: 0.3,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: ColorsConstants.appColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        showReplaceWidget ??
                        Padding(
                          padding: EdgeInsets.all(paddingAll ?? 16),
                          child: Icon(Icons.person,
                              color: ColorsConstants.appColor, size: 16),
                        ),
                  )
                : showReplaceWidget ??
                    Padding(
                      padding: EdgeInsets.all(paddingAll ?? 16),
                      child: Icon(Icons.person,
                          color: ColorsConstants.appColor, size: 16),
                    ),
      ),
    );
  }
}
