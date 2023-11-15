// ignore_for_file: file_names, prefer_const_constructors, unused_import, duplicate_ignore, use_build_context_synchronously
import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/pages/Navbar.dart';
import 'package:newbmi_app/pages/showpreviousdata.dart';
import 'package:newbmi_app/reusable/app_colors.dart';
import 'package:newbmi_app/reusable/dialog_box.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/widgets/button_widget.dart';
import '../gender.dart';
import 'displaypage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<FirstPage> {
  Gender selectedCard = Gender.male;
  int sliderValue1 = 150; //height
  int sliderValue2 = 50; //weight
  String name = '';
  String address = '';
  String sex = 'Male';
  String myAge = '0 years, 0 months and 0 days';
  DateTime pickedDate = DateTime.now();
  DateTime today = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController inputController = TextEditingController();
  late String result;
  final user = FirebaseAuth.instance.currentUser!;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  //document IDs
  List<String> docIDs = [];

  //get IDS
  Future getdocIDS() async {
    await FirebaseFirestore.instance.collection('bmi_data').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        calculateAge(pickedDate);
        today = pickedDate;
      }
    });
  }

  void calculateAge(DateTime birth) {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    int months = (age.inDays % 365) ~/ 30;
    int days = ((age.inDays % 365) % 30);
    setState(() {
      myAge = '$years years, $months months and $days days';
    });
  }

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
    getdocIDS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return firsta_alertdialog();
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
          //backgroundColor: Colors.grey[300],
          //resizeToAvoidBottomInset: false,
          drawer: NavBar(),
          appBar: AppBar(
            title: fistpageappbar_title_texts(user: user),
            flexibleSpace: appbar_colour(),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.preview,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => showpreviousdata(
                              name: '$name',
                            )),
                  );
                },
              ),

              // MaterialButton(
              //   onPressed: () {
              //     logout();
              //   },
              //   child: Image.asset('assets/logout.gif', width: 30, height: 30,alignment: AlignmentDirectional.centerEnd,))
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {
                  logout();
                },
              )
            ],
            foregroundColor: Colors.black,
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/home1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(colors: [
                  //       Colors.white,
                  //       Colors.grey,
                  //       Colors.black,
                  //       Colors.white,
                  //       Colors.black,
                  //       Colors.grey,

                  //     ],begin: Alignment.topCenter, end: Alignment.bottomCenter
                  //     ),
                  //   ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCard = Gender.male;
                                  sex = 'Male';
                                });
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.mars,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/male.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: selectedCard == Gender.male
                                      ? Colors.blue
                                      : Colors.grey.shade200,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCard = Gender.female;
                                  sex = 'Female';
                                });
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.venus,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/female.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: selectedCard == Gender.female
                                      ? Colors.pink
                                      : Colors.grey.shade200,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            // inputFormatters: [
                            //   FilteringTextInputFormatter(
                            //   RegExp("[a-zA-Z]"),
                            //   allow: true),
                            //   ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name cannot be blank';
                              } else if (RegExp("[0-9`~!@#%^&*?><,/]")
                                  .hasMatch(value)) {
                                return "can't enter numbers or spesial characters";
                              }
                              return null;
                            },
                            style: text_style_firstpage(),
                            maxLength: 30,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              focusedBorder: border_OutlineInputBorder(),
                              enabledBorder: enabledBorder_outlineInputBorder(),
                              hintText: 'Enter your name',
                              hintStyle: text_style_firstpage(),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (vals) => name = vals,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address cannot be blank';
                              }
                              return null;
                            },
                            style: text_style_firstpage(),
                            maxLength: 50,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              focusedBorder: border_OutlineInputBorder(),
                              enabledBorder: enabledBorder_outlineInputBorder(),
                              hintText: 'Enter your address',
                              hintStyle: text_style_firstpage(),
                              prefixIcon: Icon(
                                Icons.location_city_rounded,
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (vals) => address = vals,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: _showDatePicker,
                              child: Container(
                                height: 85,
                                width: 85,
                                // margin: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/calander1.gif"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                  //color: Color.fromRGBO(13, 180, 66, 0.922),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                _showDatePicker();
                              },
                              child: Container(
                                width: 200,
                                height: 85,
                                child: Card(
                                  color: Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    padding: new EdgeInsets.all(10.0),
                                    child: Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        selectionColor: Colors.black,
                                        text: TextSpan(
                                          text: 'Select birthday\n',
                                          style: GoogleFonts.oswald(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          /*defining default style is optional */
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${today.year}-${today.month}-${today.day}',
                                                style: GoogleFonts.oswald(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey,
                                                  fontSize: 20,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              height: 110,
                              // ignore: sort_child_properties_last
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text('Height', style: text_style_firstpage()),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        sliderValue1.toString(),
                                        style: GoogleFonts.oswald(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      Text(
                                        "cm",
                                        style: TextStyle(
                                            color: Colors.red.withOpacity(0.8),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (sliderValue1 >= 2)
                                              sliderValue1--;
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 12,
                                          child: Icon(
                                            FontAwesomeIcons.minus,
                                            color: const Color.fromARGB(
                                                255, 148, 136, 136),
                                          ),
                                        ),
                                      ),
                                      SliderTheme(
                                        data: SliderThemeData(
                                            thumbColor: Colors.green,
                                            //thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                                            trackHeight: 30),
                                        child: Slider(
                                          value: sliderValue1.toDouble(),
                                          min: 1.0,
                                          max: 300.0,
                                          //divisions: 10,

                                          onChanged: (value) {
                                            setState(() {
                                              sliderValue1 = value.toInt();
                                            });
                                          },
                                          inactiveColor: Colors.grey.shade400,
                                          activeColor:
                                              Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (sliderValue1 <= 299) {
                                              sliderValue1++;
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 12,
                                          child: Icon(
                                            FontAwesomeIcons.plus,
                                            color: const Color.fromARGB(
                                                255, 148, 136, 136),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 110,
                                    // height: MediaQuery.of(context).size.height,
                                    // width: MediaQuery.of(context).size.width,
                                    // ignore: sort_child_properties_last
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text('Weight',
                                            style: text_style_firstpage()),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              sliderValue2.toString(),
                                              style: GoogleFonts.oswald(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "kg",
                                              style: TextStyle(
                                                  color: Colors.red
                                                      .withOpacity(0.8),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (sliderValue2 >= 2)
                                                    sliderValue2--;
                                                });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                radius: 12,
                                                child: Icon(
                                                  FontAwesomeIcons.minus,
                                                  color: const Color.fromARGB(
                                                      255, 148, 136, 136),
                                                ),
                                              ),
                                            ),
                                            SliderTheme(
                                              data: SliderThemeData(
                                                  thumbColor: Colors.green,
                                                  //thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                                                  trackHeight: 30),
                                              child: Slider(
                                                value: sliderValue2.toDouble(),
                                                min: 1.0,
                                                max: 250.0,
                                                onChanged: (value) {
                                                  setState(() {
                                                    sliderValue2 =
                                                        value.toInt();
                                                  });
                                                },
                                                inactiveColor:
                                                    Colors.grey.shade400,
                                                activeColor: Colors.black
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (sliderValue2 <= 249) {
                                                    sliderValue2++;
                                                  }
                                                });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                radius: 12,
                                                child: Icon(
                                                  FontAwesomeIcons.plus,
                                                  color: const Color.fromARGB(
                                                      255, 148, 136, 136),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                result = inputController.text;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DisplaytPage(
                                          height: sliderValue1,
                                          weight: sliderValue2,
                                          myAge: myAge,
                                          name: name,
                                          address: address,
                                          gender: sex,
                                          year: today.year,
                                          month: today.month,
                                          day: today.day,
                                        )),
                              );
                            }
                          },
                          child: ButtonWidget(
                              backgroundcolor:
                                  AppColors.mainColor.withOpacity(0.8),
                              text: "Submit",
                              textcolor: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          // ),
          ),
    );
  }

  void logout() async {
    //await FirebaseAuth.instance.signOut();

    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            // backgroundColor:
            //     Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
            //title: Text('Alert'),
            title: Text(
              'Do you want to Logout?',
              style:
                  GoogleFonts.oswald(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: GoogleFonts.oswald(),
                  )),
              TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    //Navigator.of(context).pop(context);
                    Navigator.of(context).popUntil((route) => route.isFirst);

                    // .then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()),(route) => false)));
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return CupertinoAlertDialog(
                            title: Text(
                              'Logout Successfull',
                              style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.center,
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
                            //       onPressed: () {}),
                            // ],
                          );
                        });

                    //  showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return Center(child: CircularProgressIndicator());
                    //     });
                  },
                  child: Text(
                    'Yes',
                    style: GoogleFonts.oswald(),
                  )),
            ],
          );
        });
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
}

TextStyle text_style_firstpage() {
  return GoogleFonts.oswald(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}

OutlineInputBorder enabledBorder_outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: Colors.white,
      ));
}

OutlineInputBorder border_OutlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: Colors.grey.shade700,
      ));
}






// showDialog(
//             context: context,
//             builder: (BuildContextcontext) => CupertinoAlertDialog(
//                   title: Text(
//                     'No Connection',
//                     style: GoogleFonts.oswald(),
//                   ),
//                   content: Text(
//                     'Please check your internet connectivity',
//                     style: GoogleFonts.oswald(),
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                         onPressed: () async {
//                           Navigator.pop(context, 'Cancle');
//                           setState(
//                             () => isAlertSet = false,
//                           );
//                           isDeviceConnected =
//                               await InternetConnectionChecker().hasConnection;
//                               if(!isDeviceConnected){
                                
//                               }
//                         },
//                         child: Text(
//                           'OK',
//                           style: GoogleFonts.oswald(),
//                         ))
//                   ],
//                 ));