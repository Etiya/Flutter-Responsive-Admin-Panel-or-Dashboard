import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          const  Divider(),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              if (Responsive.isMobile(context)) {
                Navigator.of(context).pop();
              }
              context
                  .read<MenuController>()
                  .setMenuScreen(MenuScreen.dashboard);
            },
          ),
          DrawerListTile(
            title: "App Version",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              if (Responsive.isMobile(context)) {
                Navigator.of(context).pop();
              }
              context
                  .read<MenuController>()
                  .setMenuScreen(MenuScreen.appVersion);
            },
          ),
          DrawerListTile(
            title: "Maintenance Mode",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              if (Responsive.isMobile(context)) {
                Navigator.of(context).pop();
              }
              context
                  .read<MenuController>()
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
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
