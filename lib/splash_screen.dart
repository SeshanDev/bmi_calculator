import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newbmi_app/main.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context)=>PageSwitcher(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
       // color: Colors.red,
      //  decoration: BoxDecoration(
                      // gradient: LinearGradient(colors: [
                        
                      //   Colors.white,
                      //   Colors.white,
                      //   Colors.white,
                      //   // Colors.grey,
                      //   // Colors.black,

                      // ],begin: Alignment.topCenter, end: Alignment.bottomCenter
                      // ),
      //               ),

      decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),


        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TweenAnimationBuilder(
            tween: Tween(begin: 0.0,end: 1.0),
            duration: Duration(seconds: 4),
            builder: (context,value,child){
              //int percentage = (value*100).ceil();
              return Container(
                width: 350,
                height: 350,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect){
                        return SweepGradient(
                            startAngle: 0.0,
                            endAngle: 3.14*2,
                            stops: [value,value],
                            // 0.0 , 0.5 , 0.5 , 1.0
                            center: Alignment.center,
                            colors: [Colors.black,Colors.grey.withAlpha(55)]
                        ).createShader(rect);
                      },
                      child: Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: Image.asset("assets/radial_scale.png").image)
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 350-50,
                        height: 350-50,
                        decoration: BoxDecoration(
                            //color: Colors.grey,
                            gradient: LinearGradient(colors: [
                                  
                                  Colors.grey,
                                  Colors.white,
                                  Colors.grey,
                                  // Colors.grey,
                                  // Colors.black,

                                ],begin: Alignment.topCenter, end: Alignment.bottomCenter
                                ),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(
                                  FontAwesomeIcons.calculator,
                                  color: Colors.black,
                                  size: 80,
                                  ),

                                  Center(
                                    child: DefaultTextStyle(
                                      style: GoogleFonts.bebasNeue(
                                        fontSize: 25,
                                        color: Colors.black,

                                      ),
                                      child: AnimatedTextKit(
                                        pause: Duration(microseconds: 5000),
                                        repeatForever: false,
                                        totalRepeatCount: 1,
                                        animatedTexts: [
                                          RotateAnimatedText("BMI CALCULATOR",
                                          textStyle: GoogleFonts.oswald(
                                            fontWeight: FontWeight.bold
                                          ),
                                          rotateOut: false
                                          ),
                                          RotateAnimatedText("@SN",
                                          textStyle: GoogleFonts.oswald(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                          ),),
                                          
                                        ],),
                                    ),
                                  )

                              // Text("BMI CALCULATOR\n",
                              // style: GoogleFonts.bebasNeue(
                              // fontSize: 30,
                              // color: Colors.black
                              // ),),

                              //     Text("@Sn",
                              //     style: GoogleFonts.bebasNeue(
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.w700,
                              //     color: Colors.blueGrey
                              //   ),),
                            ],
                          ),

                          
                          
                          ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
                //  Icon(
                //        FontAwesomeIcons.calculator,
                //        color: Colors.black,
                //        size: 300,
                //        ),


                //        SizedBox(
                //       height: 30,
                //     ),
                    
                // Text(
                //   'BMI',
                //   style: GoogleFonts.bebasNeue(
                //     fontSize: 52,
                //     fontWeight: FontWeight.w700,
                //     color: Colors.black.withOpacity(0.8),
                //   ),
                // ),
                // SizedBox(
                //       height: 10,
                //     ),
                //     Text("CALCULATOR",
                //     style: GoogleFonts.bebasNeue(
                //     fontSize: 52,
                //     fontWeight: FontWeight.w700,
                //     color: Colors.black.withOpacity(0.8),
                //   ),),

                //   SizedBox(
                //       height: 5,
                //     ),
                  //   Text("@Sn",
                  //   style: GoogleFonts.bebasNeue(
                  //   fontSize: 10,
                  //   fontWeight: FontWeight.w700,
                  //   color: Colors.grey.withOpacity(0.9),
                  // ),),
              ],
            ),
            
          ),
        ),
      ),
    );
  }
}
