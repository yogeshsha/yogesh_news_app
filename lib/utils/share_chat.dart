import 'package:flutter/material.dart';

import '../main.dart';
import 'app.dart';

class ShareChat {
  static void handleDeeplink(Uri? uri,{Function? onNext}) {
    if (uri != null) {
      changeScreen(uri.toString(),onNext:onNext);
    }
  }

  static void changeScreen(String url,{Function? onNext}) {
    NavigatorState? navigator = navigatorKey.currentState;
    if(navigator != null){
      try {
        Uri? uri = Uri.tryParse(url);
        if (uri != null) {
          AppHelper.myPrint("------------------- Url --------------------");
          AppHelper.myPrint(url);
          AppHelper.myPrint(uri.path);
          AppHelper.myPrint(uri.queryParameters);
          AppHelper.myPrint("-----------------------");

          if (uri.pathSegments.length > 1) {
            if (uri.pathSegments.contains("news")) {
              int? id = int.tryParse(uri.pathSegments.last);
              if (id != null) {
                navigator.pushNamed("/searchDetailScreen",arguments: {
                  "id":id
                });
              }
            }
          }
        }
      } catch (e) {
        AppHelper.myPrint("----------------- Deep Link Error ------------------");
        AppHelper.myPrint(e);
        AppHelper.myPrint("-----------------------------------");
      }
    }

  }
}
