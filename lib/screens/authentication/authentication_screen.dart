import 'package:admin/constants.dart';
import 'package:admin/controllers/authentication_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/authentication/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthenticationController>(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Login"),
      ),
      body: AuthWidget(
        padding: 50,
        emailController: _emailController,
        passwordController: _passwordController,
        authController: authController,
      ),
    );
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.authController,
    required this.padding,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthenticationController authController;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding).r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            cursorColor: Colors.orange,
            decoration: InputDecoration(
              hintText: "mail",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            cursorColor: Colors.orange,
            decoration: InputDecoration(
              hintText: "password",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          if (authController.state == AuthenticationState.loading)
            const Center(child: CircularProgressIndicator()),
          if (authController.state == AuthenticationState.loaded ||
              authController.state == AuthenticationState.initial)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(245, 130, 31, 1)),
                  ),
                  onPressed: () {
                    authController.signIn(
                        emailController.text, passwordController.text);
                  },
                  child: const Text("Login"),
                ),
                16.verticalSpace,
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text("Click to register")),
              ],
            ),
          if (authController.state == AuthenticationState.error)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(245, 130, 31, 1)),
                  ),
                  onPressed: () {
                    authController.signIn(
                        emailController.text, passwordController.text);
                  },
                  child: const Text("Login"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text("Click to register"),
                ),
                const Text(
                  "Tekrar Deneyiniz",
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
        ],
      ),
    );
  }
}
