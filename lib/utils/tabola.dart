import 'package:flutter/material.dart';
import 'package:newsapp/utils/app.dart';
import 'package:taboola_sdk/classic/taboola_classic.dart';
import 'package:taboola_sdk/classic/taboola_classic_listener.dart';
import 'package:taboola_sdk/taboola.dart';

TaboolaClassicBuilder taboolaClassicBuilder =
    Taboola.getTaboolaClassicBuilder("http://www.example.com", "article");

class TaboolaCustomClass {
  TaboolaCustomClass();

  Widget setListContent() {
    Taboola.init(PublisherInfo("sdk-tester-rnd"));

    TaboolaClassicListener taboolaClassicListener = TaboolaClassicListener(
        _taboolaDidResize,
        _taboolaDidShow,
        _taboolaDidFailToLoad,
        _taboolaDidClickOnItem);

    TaboolaClassicUnit taboolaClassicUnit = taboolaClassicBuilder.build(
        "mid article widget",
        "alternating-1x2-widget",
        false,
        taboolaClassicListener,
        keepAlive: true);
    return taboolaClassicUnit;
  }

//Taboola Standard listeners
  void _taboolaDidShow(String placement) {
    AppHelper.myPrint("taboolaDidShow");
  }

  void _taboolaDidResize(String placement, double height) {
    AppHelper.myPrint("publisher did get height $height");
  }

  void _taboolaDidFailToLoad(String placement, String error) {
    AppHelper.myPrint(
        "publisher placement:$placement did fail with an error:$error");
  }

  bool _taboolaDidClickOnItem(
      String placement, String itemId, String clickUrl, bool organic) {
    AppHelper.myPrint(
        "publisher did click on item: $itemId with clickUrl: $clickUrl in placement: $placement of organic: $organic");
    if (organic) {
      //_showToast("Publisher opted to open click but didn't actually open it.");
      AppHelper.myPrint("organic");
    } else {
      // _showToast("Publisher opted to open clicks but the item is Sponsored, SDK retains control.");
      AppHelper.myPrint("SC");
    }
    return false;
  }
}
