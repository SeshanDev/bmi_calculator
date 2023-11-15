// ignore_for_file: dead_code, unused_import, prefer_const_literals_to_create_immutables

//import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/pages/inputdatapage.dart';
import 'package:newbmi_app/pages/showpreviousdata.dart';
import 'package:newbmi_app/reusable/app_colors.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/reusable/dialog_box.dart';
import 'package:newbmi_app/reusable/wheel.dart';
import 'package:newbmi_app/widgets/button_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';
import '../Models/user_model.dart';

// ignore: must_be_immutable
class finalPage extends StatefulWidget {
  String name;
  String address;
  int height;
  int weight;
  String gender;
  String myAge;
  int year;
  int month;
  int day;
  String? bmiStatus;
  String? bmiInterpretation;
  Color? bmiStatusColor;

  // ignore: use_key_in_widget_constructors
  finalPage({
    required this.name,
    required this.address,
    required this.height,
    required this.weight,
    required this.gender,
    required this.myAge,
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  _finalPageState createState() => _finalPageState();
}

class _finalPageState extends State<finalPage> {
  double bmires = 0;
  double value = 0.0;
  Color? progesscolor;
  String bmiStatus = '';
  String? bmiInterpretation;
  Color? bmiStatusColor;
  double actualweight1 = 0;
  double actualweight2 = 0;
  String actualweight = '';
  String name = '';
  String address = '';
  int height = 150;
  String gender = 'male';
  String myAge = '';
  String image = 'assets/nothing_bmi.gif';
  final user = FirebaseAuth.instance.currentUser!;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  Widget build(BuildContext context) {
    double bmires = 0;
    int weight = widget.weight;
    bmires = weight / pow(widget.height / 100, 2);

    //lower value
    actualweight1 = 19.0 * pow(widget.height / 100, 2);

    //higher value
    actualweight2 = 25.0 * pow(widget.height / 100, 2);

    setBmiInterpretation(bmires);
    setcircle(bmires);

    getConnectivity() {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialodBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });
    }

    @override
    void dispose() {
      subscription.cancel();
      super.dispose();
    }

    @override
    void initState() {
      getConnectivity();
      super.initState();
    }

    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return previous_pagedailog();
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: finalpageappbar_tilte(user: user),

          flexibleSpace: appbar_colour(),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.share,
                ),
                onPressed: () {
                  Share.share(
                      "Your BMI is ${bmires.toStringAsFixed(2)}.\nYour age is ${widget.myAge}.");
                }),
            IconButton(
              icon: Icon(
                Icons.preview,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => showpreviousdata(
                            name: '${widget.name}',
                          )),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.save,
              ),
              onPressed: () {
                // print("user information");
                // print("=====================");
                // print("${widget.name}");
                // print("${widget.address}");
                // print("${widget.myAge}");
                // print("${widget.height}");
                // print("${widget.weight}");
                // print("${widget.gender}");
                // print("$bmires");
                // print("$bmiStatus!");

                addbmidata(name, address, height, weight, gender, myAge, bmires,
                    bmiStatus);
              },
            ),
          ],

          foregroundColor: Colors.black,
          // leading: IconButton(
          //   icon: Icon(Icons.menu,),
          //   onPressed: (){},
          // ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.grey[900],
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                //  decoration: BoxDecoration(
                //         gradient: LinearGradient(colors: [
                //           Colors.white,
                //           Colors.grey,
                //           Colors.black,
                //           Colors.white,
                //           Colors.black,
                //           Colors.grey,

                //         ],begin: Alignment.bottomRight, end: Alignment.topRight
                //         ),
                //       ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Image(
                          image: AssetImage(image),
                          height: 130,
                        ),
                      ),

                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: ('YOUR AGE\n'),
                              style: GoogleFonts.oswald(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            WidgetSpan(
                              child: SizedBox(width: 30),
                            ),
                            TextSpan(
                              text: '${widget.myAge}',
                              style: GoogleFonts.oswald(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "YOUR BMI RESULT\n",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),

                      Center(
                          child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1500,
                        radius: 120,
                        lineWidth: 35,
                        percent: value,
                        progressColor: progesscolor,
                        backgroundColor: Colors.blueGrey.shade400,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          bmires.toStringAsFixed(2),
                          style: GoogleFonts.oswald(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: bmiStatusColor),
                        ),
                        footer: IconButton(
                            onPressed: () {
                              InfoshowDialodBox();
                            },
                            icon: Icon(Icons.info)),
                      )),

                      // PrettyGauge(
                      //   gaugeSize: 250,
                      //   minValue: 0,
                      //   maxValue: 40,
                      //   segments: [
                      //     GaugeSegment('UnderWeight', 18.5, Colors.red),
                      //     GaugeSegment('Normal', 6.4,
                      //         Color.fromARGB(255, 19, 109, 49)),
                      //     GaugeSegment('OverWeight', 5, Colors.orange),
                      //     GaugeSegment('Obese', 10.1, Colors.pink),
                      //   ],
                      //   valueWidget: Text(
                      //     bmires.toStringAsFixed(2),
                      //     style: const TextStyle(fontSize: 40),
                      //   ),
                      //   currentValue: bmires.toDouble(),
                      //   needleColor: const Color.fromARGB(255, 36, 50, 61),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        bmiStatus,
                        style: GoogleFonts.oswald(
                            fontSize: 25, color: bmiStatusColor!),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        bmiInterpretation!,
                        style: GoogleFonts.oswald(
                            fontSize: 20, color: bmiStatusColor!),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        actualweight,
                        style: GoogleFonts.oswald(
                          fontSize: 20,
                          color: bmiStatusColor!,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //           ])),
                      // ),
                      SizedBox(
                        height: 35,
                      ),
                      MaterialButton(
                        onPressed: () {
                          _reset();
                        },
                        child: ButtonWidget(
                            backgroundcolor:
                                AppColors.mainColor.withOpacity(0.8),
                            text: "Reset and try again..",
                            textcolor: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      boxShadow: [
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
    );
  }

  void setBmiInterpretation(double bmires) {
    if (bmires > 30) {
      bmiStatus = "Obesity";
      bmiInterpretation = "Please work to reduce obesity\n";
      bmiStatusColor = Colors.pink;
      actualweight =
          "Your weight should be within the ${actualweight1.toStringAsFixed(4)}kg-${actualweight2.toStringAsFixed(4)}kg range for your height ";
    } else if (bmires >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight\n";
      bmiStatusColor = Colors.orange;
      actualweight =
          "Your weight should be within the ${actualweight1.toStringAsFixed(2)}kg-${actualweight2.toStringAsFixed(2)}kg range for your height ";
    } else if (bmires >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit\n";
      bmiStatusColor = Color.fromARGB(255, 19, 109, 49);
      actualweight =
          "Your healthy weight range is ${actualweight1.toStringAsFixed(2)}kg-${actualweight2.toStringAsFixed(2)}kg ";
    } else if (bmires < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight\n";
      bmiStatusColor = Colors.red;
      actualweight =
          "Your weight should be within the ${actualweight1.toStringAsFixed(2)}kg-${actualweight2.toStringAsFixed(2)}kg range for your height ";
    }
  }

  void setcircle(double bmires) {
    if ((bmires / 100) <= 0.0) {
      value = 0.0;
      progesscolor = Colors.red;
      image = 'assets/nothing_bmi.gif';
    } else if ((bmires / 100) >= 1.0) {
      value = 1.0;
      progesscolor = Colors.red;
      image = 'assets/red_bmi.gif';
    } else if ((bmires / 100) > 0.4) {
      progesscolor = Colors.red;
      value = 1.0;
      image = 'assets/red_bmi.gif';
    } else if ((bmires / 100) >= 0.3) {
      progesscolor = Colors.orange;
      value = (bmires / 100) * 2;
      image = 'assets/orange_bmi.gif';
    } else if ((bmires / 100) >= 0.25) {
      progesscolor = Colors.orange.shade300;
      value = (bmires / 100) * 2;
      image = 'assets/orange_shade_bmi.gif';
    } else if ((bmires / 100) >= 0.185) {
      progesscolor = Colors.green;
      value = (bmires / 100) * 2;
      image = 'assets/green_bmi.gif';
    } else if ((bmires / 100) < 0.185) {
      progesscolor = Colors.red;
      value = (bmires / 100) * 2;
      image = 'assets/red_bmi.gif';
    }
  }

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => FirstPage(),
      ),
    );
  }

  void addbmidata(String name, String address, int height, int weight,
      String gender, String myAge, double bmires, String bmiStatus) {
    final user = FirebaseAuth.instance.currentUser!;
    var document = UserModel(
      address: widget.address,
      bmiStatus: '$bmiStatus',
      bmires: '${bmires.toStringAsFixed(2)}',
      gender: '${widget.gender}',
      height: '$height',
      myAge: '${widget.myAge}',
      name: widget.name,
      weight: '$weight',
      email: user.email!,
    );

    try {
      FirebaseFirestore.instance.collection('bmi_data').add(document.toJson());

      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
              // backgroundColor:
              //     Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
              //title: Text('Alert'),
              title: Text(
                'You data has been saved..',
                style: GoogleFonts.oswald(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
              content: Image.asset(
                'assets/success1.gif',
                height: 40,
                width: 40,
              ),
              // actions: [
              //   IconButton(
              //       iconSize: 60.0,
              //       icon: Image.asset(
              //         'assets/success1.gif',
              //       ),
              //       onPressed: () {
              //         Navigator.pop(context);
              //       }),
              // ],
            );
          });
    } on FirebaseAuthException catch (error) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                error.message.toString(),
                style: GoogleFonts.oswald(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
              content: Image.asset(
                'assets/unsuccess1.gif',
                height: 40,
                width: 40,
              ),
              // actions: [
              //   IconButton(
              //       iconSize: 60.0,
              //       icon: Image.asset(
              //         'assets/unsuccess1.gif',
              //       ),
              //       onPressed: () {
              //         Navigator.pop(context);
              //       }),
              // ],
            );
          });
    }
  }

  showDialodBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(
              'No Connection',
              style: GoogleFonts.oswald(),
            ),
            content: Text(
              'Please check your internet connectivity',
              style: GoogleFonts.oswald(),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancle');
                    setState(() async {
                      isAlertSet = false;
                      isDeviceConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (!isDeviceConnected) {
                        showDialodBox();
                        setState(
                          () => isAlertSet = true,
                        );
                      }
                    });
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.oswald(),
                  ))
            ],
          ));

  InfoshowDialodBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(
              'Info',
              style: GoogleFonts.oswald(),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Underweight',
                      style: GoogleFonts.oswald(
                        color:Colors.red, ),
                    ),
                    Text('< 18.5',
                    style: GoogleFonts.oswald(),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Normal',
                    style: GoogleFonts.oswald(
                        color:Colors.green, ),),
                    Text('18.5-25',
                    style: GoogleFonts.oswald(),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Overweight',
                    style: GoogleFonts.oswald(
                        color:Colors.orange, ),),
                    Text('25-30',
                    style: GoogleFonts.oswald(),)
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Obesity',
                    style: GoogleFonts.oswald(
                        color:Colors.pink, ),),
                    Text('>30',
                    style: GoogleFonts.oswald(),)
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    // setState(() async {
                    //   isAlertSet = false;
                    //   isDeviceConnected =
                    //       await InternetConnectionChecker().hasConnection;
                    //   if (!isDeviceConnected) {
                    //     showDialodBox();
                    //     setState(
                    //       () => isAlertSet = true,
                    //     );
                    //   }
                    // });
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.oswald(),
                  ))
            ],
          ));
}
