import 'package:admin/screens/app_version/app_version_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

enum MenuScreen {
  dashboard,
  appVersion
}

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  Widget get menuScreenWidget {
    switch (activeMenuScreen) {
      case MenuScreen.dashboard:  return DashboardScreen();
      case MenuScreen.appVersion: return AppVersionScreen();
      default: return DashboardScreen();
    }
  }

  MenuScreen activeMenuScreen = MenuScreen.appVersion;

  setMenuScreen(MenuScreen screen) {
    activeMenuScreen = screen;
    notifyListeners();
  }
}
