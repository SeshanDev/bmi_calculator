import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/reusable/app_colors.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/widgets/button_widget.dart';
import 'finalpage.dart';
import '../gender.dart';
//import 'Navbar.dart';

// ignore: must_be_immutable
class DisplaytPage extends StatefulWidget {
  String name;
  String address;
  String myAge;
  int height;
  int weight;
  String gender;
  int year;
  int month;
  int day;

  // ignore: use_key_in_widget_constructors
  DisplaytPage({
    required this.height,
    required this.weight,
    required this.myAge,
    required this.name,
    required this.address,
    required this.gender,
    required this.year,
    required this.month,
    required this.day,
  });

  @override
  _DisplaytPageState createState() => _DisplaytPageState();
}

class _DisplaytPageState extends State<DisplaytPage> {
  Gender selectedCard = Gender.unSelected;
  int sliderValue1 = 150; //height
  int sliderValue2 = 50; //weight
  String name1 = '';
  String address1 = '';
  String sex = 'Male';
  String myAge = '0 years, 0 months and 0 days';
  
  int day = 0;
  int month = 0;
  int year = 0;
  final user = FirebaseAuth.instance.currentUser!;
   late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;


  @override
  Widget build(BuildContext context) {
    int height = widget.height;
    int weight = widget.weight;
    String myAge = widget.myAge;
    String name1 = widget.name;
    String address1 = widget.address;
    String sex = widget.gender;
   


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
    

    return Scaffold(
      backgroundColor: Colors.grey[300],
      //resizeToAvoidBottomInset: false,
      //drawer: Navbar(),
      appBar: AppBar(
        title:  displayappbar_title(user: user), 
        
        flexibleSpace: appbar_colour(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications,
              ),
              onPressed: () {})
        ],
        foregroundColor: Colors.black,
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/home1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              // decoration: BoxDecoration(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Image(
                      image: AssetImage("assets/home.gif"),
                      height: 150,
                    ),
                  ),
          
                  //        Expanded(
          
                  //     child: Image (image: NetworkImage(
                  //       'https://i.gifer.com/origin/d5/d596494e332f8953d411d6a33a190e07_w200.webp'),
                  //       height: 100,
                  //       ),
          
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                   Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: Container(
                       decoration: decoration(),
                       child: Card(
                        color: Colors.grey.shade200,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              selectionColor: Colors.black,
                              text: TextSpan(
                                text: 'YOUR NAME',
                                style: display_text(),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n${widget.name}',
                                      style: display_2_text() ,),
                                ],
                              ),
                            ),
                          ),
                        ),
                                       ),
                     ),
                   ),
          
                  //Text(
                  //   "YOUR NAME  \n${widget.name}",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  // ),
                  // width: 400,
                  // color: const Color.fromARGB(255, 148, 136, 136),
                  SizedBox(height: 10,),
          
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                       decoration: decoration(),
                      child: Card(
                        color: Colors.grey.shade200,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              selectionColor: Colors.black,
                              text: TextSpan(
                                text: 'YOUR ADDRESS',
                                style: display_text(),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n${widget.address}',
                                      style: display_2_text(),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
          
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                       decoration: decoration(),
                      child: Card(
                        color: Colors.grey.shade200,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              selectionColor: Colors.black,
                              text: TextSpan(
                                text: 'YOUR BIRTHDAY',
                                style: display_text(),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '\n${widget.year}-${widget.month}-${widget.day}',
                                      style: display_2_text() ,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
          
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                       decoration: decoration(),
                      child: Card(
                        color: Colors.grey.shade200,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              selectionColor: Colors.black,
                              text: TextSpan(
                                text: 'YOUR HEIGHT(cm)',
                                style: display_text(),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n${widget.height}',
                                      style: display_2_text() ,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
          
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                       decoration: decoration(),
                      child: Card(
                        color: Colors.grey.shade200,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              selectionColor: Colors.black,
                              text: TextSpan(
                                text: 'YOUR WEIGHT(kg)',
                                style: display_text(),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n${widget.weight}',
                                      style: display_2_text(),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
          
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                       decoration: decoration(),
                      child: Card(
                        color: Colors.grey.shade200,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              selectionColor: Colors.black,
                              text: TextSpan(
                                text: 'YOUR GENDER',
                                style: display_text(),
                                
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n${widget.gender}',
                                      style: display_2_text() ,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 35,),





                  MaterialButton(
                         onPressed: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => finalPage(
                                  name: name1, 
                                  address: address1, 
                                  height: height,
                                  weight: weight,
                                  myAge: myAge,  
                                  gender: sex,
                                  day: day,
                                  month: month, 
                                  year: year,
                                )),
                      );
                           
                            },
                              child: ButtonWidget(backgroundcolor: AppColors.mainColor.withOpacity(0.8),
                              text: "Calculate", 
                              textcolor: Colors.black),
                            ),
                            SizedBox(height: 10,),


                ],
              ),
            ),
          ),
        ),
      ),
    );
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






  TextStyle display_text() {
    return GoogleFonts.oswald(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            );
  }

    TextStyle display_2_text() {
    return GoogleFonts.oswald(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
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
                  );
  }
}


