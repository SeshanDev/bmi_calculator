// ignore_for_file: unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/reusable/dialog_box.dart';

// ignore: must_be_immutable
class showpreviousdata extends StatefulWidget {
  String name;
  // ignore: use_key_in_widget_constructors
  showpreviousdata({
    required this.name,
  });

  @override
  _showpreviousdataState createState() => _showpreviousdataState();
}

final user = FirebaseAuth.instance.currentUser!;
late StreamSubscription subscription;
var isDeviceConnected = false;
bool isAlertSet = false;

class _showpreviousdataState extends State<showpreviousdata> {
  @override

  
  Widget build(BuildContext context) {
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
        resizeToAvoidBottomInset: false,
        //drawer: Navbar(),
        appBar: AppBar(
          title:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Previous Data",
              style: GoogleFonts.oswald(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            
            ),
            Text(
              "Signed in as: ${FirebaseAuth.instance.currentUser!.email}",
              style: GoogleFonts.oswald(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            
            ),
          ],
        ),
       
          flexibleSpace: appbar_colour(),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  deletedata();
                })
          ],
          foregroundColor: Colors.black,
        ),
    
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/home1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              //  decoration: BoxDecoration(
              //             gradient: LinearGradient(colors: [
              //               Colors.grey,
              //                Colors.black,
              //               Colors.grey,
              //               Colors.white,
              //               Colors.grey,
              
              //             ],begin: Alignment.topCenter, end: Alignment.bottomCenter
              //             ),
              //           ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Image(
                      image: AssetImage("assets/home.gif"),
                      height: 20,
                    ),
                  ),
              
                           Container(
                            decoration: decoration(),
                             child: Card(
                                    color: Colors.grey.shade200,
                                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      width: 350,
                                      color: Colors.grey.shade200,
                                      padding: new EdgeInsets.all(10.0),
                                      child: Center(
                                        // ignore: prefer_const_constructors
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: ('Name'),
                                                style: tabletitle_text(),
                                              ),
                                               WidgetSpan(
                                                child: SizedBox(width: 30),
                                                ),
                                              TextSpan(
                                                text:
                                                    'BmiStatus',
                                                style: tabletitle_text(),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(width: 30),
                                                ),
                                              TextSpan(
                                                text: 'Bmires', 
                                                style: tabletitle_text(),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                           ),
                
              
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('bmi_data')
                          .where('email',
                              isEqualTo: FirebaseAuth.instance.currentUser!.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(FirebaseAuth.instance.currentUser!.email.toString() +
                            "sdssdsdd11");
                        List<Row> bmiWidgets = [];
                        if (snapshot.hasData) {
                          final bmi = snapshot.data?.docs.toList();
                          for (var bmi_data in bmi!) {
                            final bmiWidget = Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
              
                                Container(
                                  decoration: decoration(),
                                  child: Card(
                                    color: Colors.grey.shade200,
                                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Container(
                                      width: 350,
                                      color: Colors.grey.shade200,
                                      padding: new EdgeInsets.all(10.0),
                                      child: Center(
                                        // ignore: prefer_const_constructors
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: bmi_data['name'],
                                                style: show_text(),
                                              ),
                                               WidgetSpan(
                                                child: SizedBox(width: 30),
                                                ),
                                              TextSpan(
                                                text:
                                                    bmi_data['bmiStatus'],
                                                style: show_text(),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(width: 30),
                                                ),
                                              TextSpan(
                                                text: bmi_data['bmires'], 
                                                style: show_text(),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                
              
              
              
              
              
              
              
              
                                // Text(
                                //   bmi_data['name'],
                                //   style: const TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.bold,
                                //     color: const Color.fromARGB(255, 148, 136, 136),
                                //   ),
                                // ),
                                // Text(
                                //   bmi_data['bmiStatus'],
                                //   style: const TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.bold,
                                //     color: const Color.fromARGB(255, 148, 136, 136),
                                //   ),
                                // ),
                                // Text(
                                //   bmi_data['bmires'],
                                //   style: const TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.bold,
                                //     color: const Color.fromARGB(255, 148, 136, 136),
                                //   ),
                                // ),
                              ],
                            );
                            bmiWidgets..add(bmiWidget);
                          }
                        }
              
                        return Expanded(
                          child: ListView(
                            children: bmiWidgets,
                          ),
                        );
                      })
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

  TextStyle tabletitle_text() {
    return GoogleFonts.oswald(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              );
  }

  TextStyle show_text() {
    return GoogleFonts.oswald(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey,
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
                                  color: Colors.grey.shade400,
                                  offset: Offset(-6, -6),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                      );
  }

  deletedata() async {
    
    final collection =
        await FirebaseFirestore.instance.collection("bmi_data").get();
    //final batch = FirebaseFirestore.instance.get();
    //  print(collection.docs.toString() + 'hellooooo');
    for (final doc in collection.docs) {
      if (doc.data()['email'].toString() == FirebaseAuth.instance.currentUser!.email) {
        //print('fffff');
        doc.reference.delete();
        // doc.data()['email'].
        // batch.delete(doc.reference);
      } 
    }
     return showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                // backgroundColor: Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
                title: Text('Your Previous data was removed successfully!',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),

                content: Image.asset('assets/success1.gif',height: 40,width: 40,),
                // actions: [
                //                 IconButton(
                //                   iconSize: 60.0,
                //                   icon: Image.asset('assets/success1.gif',),
                //                         onPressed: (){Navigator.pop(context);}),
                //               ],
              );
            });
  }
}


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
