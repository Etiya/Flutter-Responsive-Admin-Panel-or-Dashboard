import 'package:admin/constants.dart';
import 'package:admin/controllers/authentication_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthenticationController>(context);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Register"),
      ),
      body: Responsive(
        mobile: RegisterWidget(
          emailController: _emailController,
          passwordController: _passwordController,
          authController: authController,
          padding: 50,
        ),
        tablet: RegisterWidget(
          padding: 170,
          emailController: _emailController,
          passwordController: _passwordController,
          authController: authController,
        ),
        desktop: RegisterWidget(
          emailController: _emailController,
          passwordController: _passwordController,
          authController: authController,
          padding: 500,
        ),
      ),
    );
  }
}

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
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
            controller: passwordController,
            obscureText: true,
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
            ElevatedButton(
              onPressed: () async {
                await authController.createNewUser(
                    emailController.text, passwordController.text);
                if (authController.state == AuthenticationState.loaded) {
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(245, 130, 31, 1)),
              ),
              child: const Text("Sign up"),
            ),
          if (authController.state == AuthenticationState.error)
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await authController.createNewUser(
                        emailController.text, passwordController.text);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(245, 130, 31, 1)),
                  ),
                  child: const Text("Sign up"),
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
