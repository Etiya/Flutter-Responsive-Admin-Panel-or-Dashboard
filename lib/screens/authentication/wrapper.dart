import 'package:admin/controllers/authentication_controller.dart';
import 'package:admin/models/user_model.dart';
import 'package:admin/screens/authentication/authentication_screen.dart';
import 'package:admin/screens/main/main_panel_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationController>(context);
    return StreamBuilder<UserInfo?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<UserInfo?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final UserInfo? user = snapshot.data;
            return user == null ? const AuthScreen() : const MainScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
