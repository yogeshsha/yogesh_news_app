import 'package:flutter/material.dart';
import '../presentation/screens/bottom_navigator_screen.dart';

class DrawerProvider with ChangeNotifier {
  List<DrawerTab> drawerList = [];
  // set addDrawer(DrawerTab value) {
  //   drawerList.add(value);
  //   notifyListeners();
  // }
  List<DrawerTab> get getDrawer => drawerList;

  set addDrawer(DrawerTab drawerTab) {
    drawerList.add(drawerTab);
    notifyListeners();
  }
}