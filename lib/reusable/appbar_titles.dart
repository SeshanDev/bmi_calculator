import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class fistpageappbar_title_texts extends StatelessWidget {
  const fistpageappbar_title_texts({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "BMI APP",
          style: GoogleFonts.oswald(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        Text(
          "Signed in as: " + user.email!,
          style: GoogleFonts.oswald(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
      ],
    );
  }
}


class displayappbar_title extends StatelessWidget {
  const displayappbar_title({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BMI Calculator",
              style: GoogleFonts.oswald(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            
            ),
            Text(
              "Signed in as: "+ user.email!,
              style: GoogleFonts.oswald(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            
            ),
          ],
        );
  }
}




class finalpageappbar_tilte extends StatelessWidget {
  const finalpageappbar_tilte({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BMI RESULTS",
            style: GoogleFonts.oswald(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          
          ),
          Text(
            "Signed in as: "+ user.email!,
            style: GoogleFonts.oswald(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          
          ),
        ],
      );
  }
}







class appbar_colour extends StatelessWidget {
  const appbar_colour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: <Color>[
      //       Colors.black,
      //       Colors.black,
      //     ],
      //   ),
      // ),
    );
  }
}


