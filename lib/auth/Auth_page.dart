import 'package:flutter/material.dart';
import 'package:newbmi_app/auth/login_page.dart';
import 'package:newbmi_app/auth/Register_page.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  //initialy show the login page
  bool showloginscreen = true;
  void toggleScreens() {
    setState(() {
      showloginscreen = !showloginscreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginscreen) {
      return LoginScreen(showRegisterPage: toggleScreens);
    } else {
      return Registerpage(showloginscreen: toggleScreens);
    }
  }
}
