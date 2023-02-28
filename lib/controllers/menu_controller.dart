import 'package:admin/screens/app_version/app_version_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/maintenance_mode/maintenance_mode_screen.dart';
import 'package:flutter/material.dart';

enum MenuScreen {
  dashboard,
  appVersion,
  maintenanceMode,
}

extension MenuScreenExt on MenuScreen {
  String get title {
    var _title = "";
    switch(this) {
      case MenuScreen.dashboard:
        _title = "Dashboard";
        break;
      case MenuScreen.appVersion:
        _title = "App Version";
        break;
      case MenuScreen.maintenanceMode:
        _title = "Maintenance Mode";
        break;
    }
    return _title;
  }
}

class MenuControllers extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    final state = _scaffoldKey.currentState;
    if (state == null) { return; }
    if (!state.isDrawerOpen) {
      state.openDrawer();
    }
  }

  Widget get menuScreenWidget {
    switch (activeMenuScreen) {
      case MenuScreen.dashboard:  return const DashboardScreen();
      case MenuScreen.appVersion: return const AppVersionScreen();
      case MenuScreen.maintenanceMode: return const MaintenanceModeScreen();
      default: return const DashboardScreen();
    }
  }

  MenuScreen activeMenuScreen = MenuScreen.dashboard;

  setMenuScreen(MenuScreen screen) {
    activeMenuScreen = screen;
    notifyListeners();
  }
}
