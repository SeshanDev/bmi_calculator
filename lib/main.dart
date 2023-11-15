// ignore_for_file: unused_import

//import 'dart:html';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbmi_app/Repositorys/user_repository.dart';
import 'package:newbmi_app/auth/Auth_page.dart';
import 'package:newbmi_app/auth/Register_page.dart';
import 'package:newbmi_app/auth/login_page.dart';
import 'package:newbmi_app/firebase_options.dart';
import 'package:newbmi_app/splash_screen.dart';
import 'pages/inputdatapage.dart';

Future main() async {
  //enseure intialized
  WidgetsFlutterBinding.ensureInitialized();

  //initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(UserRepository()));
  

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splashscreen(),
    theme: ThemeData(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        )
      )
    ), //primarySwatch: Colors.purple,
  ));
}

class PageSwitcher extends StatelessWidget {
  const PageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Somehing went wrong"),
          );
        } else if (snapshot.hasData) {
          return FirstPage();
          
        } else {
          return Authpage();
          // return Registerpage(showloginscreen: () {  },);
        }
      },
    );
  }
}
