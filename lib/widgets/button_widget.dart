import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final Color backgroundcolor;
  final String text;
  final Color textcolor;
  const ButtonWidget({super.key, 
  required this.backgroundcolor, 
  required this.text, 
  required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  double.maxFinite,
      height: MediaQuery.of(context).size.height/15,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Colors.black,
        ),
        boxShadow:[
                                    //dark shadow
                                    BoxShadow(
                                      color: Colors.grey.shade500,
                                      offset: Offset(6, 6),
                                      blurRadius: 15,
                                      spreadRadius: 1,
                                    ),

                                    //light shadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-6, -6),
                                      blurRadius: 15,
                                      spreadRadius: 1,
                                    ),
                                  ],
        
        // gradient: const LinearGradient(begin: Alignment.topCenter,
        //                     end: Alignment.bottomCenter,
        //                     colors: <Color>[
                              
        //                       Colors.black,
        //                       Colors.white,
        //                      Colors.black,
            
        //                     ],
        //                   ),
      ),




      //  Center(
      //                               child: DefaultTextStyle(
      //                                 style: GoogleFonts.bebasNeue(
      //                                   fontSize: 30,
      //                                   color: Colors.black,

      //                                 ),
      //                                 child: AnimatedTextKit(
      //                                   pause: Duration(microseconds: 5000),
      //                                   repeatForever: false,
      //                                   totalRepeatCount: 1,
      //                                   animatedTexts: [
      //                                     RotateAnimatedText("BMI CALCULATOR",
      //                                     rotateOut: false
      //                                     ),
      //                                     RotateAnimatedText("@SN"),
      //                                   ],),
      //                               ),
      //                             )

      child: Center(
        child: Text(text,
                style: GoogleFonts.oswald(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
