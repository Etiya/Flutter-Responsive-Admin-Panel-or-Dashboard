import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset('assets/images/logo.png'),
              title: const Text(
                "ETIYA",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
            ),
          ),
          const Divider(),
          DrawerListTile(
            menuScreen: MenuScreen.dashboard,
            icon: FontAwesomeIcons.chartLine,
            press: () {
              if (Responsive.isMobile(context)) {
                Navigator.of(context).pop();
              }
              context
                  .read<MenuControllers>()
                  .setMenuScreen(MenuScreen.dashboard);
            },
          ),
          DrawerListTile(
            menuScreen: MenuScreen.appVersion,
            icon: FontAwesomeIcons.rocket,
            press: () {
              if (Responsive.isMobile(context)) {
                Navigator.of(context).pop();
              }
              context
                  .read<MenuControllers>()
                  .setMenuScreen(MenuScreen.appVersion);
            },
          ),
          DrawerListTile(
            menuScreen: MenuScreen.maintenanceMode,
            icon: FontAwesomeIcons.tools,
            press: () {
              if (Responsive.isMobile(context)) {
                Navigator.of(context).pop();
              }
              context
                  .read<MenuControllers>()
                  .setMenuScreen(MenuScreen.maintenanceMode);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.menuScreen,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final MenuScreen menuScreen;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: FaIcon(
        icon,
        color: Colors.white70,
        size: 18,
      ),
      title: Text(
        menuScreen.title,
        style: TextStyle(
          color: context.read<MenuControllers>().activeMenuScreen == menuScreen
              ? Colors.white70
              : Colors.white54,
          fontWeight:
              context.read<MenuControllers>().activeMenuScreen == menuScreen
                  ? FontWeight.w900
                  : FontWeight.w300,
        ),
      ),
    );
  }
}
