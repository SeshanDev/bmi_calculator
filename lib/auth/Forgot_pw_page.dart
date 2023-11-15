import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/pages/showpreviousdata.dart';
import 'package:newbmi_app/reusable/app_colors.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/widgets/button_widget.dart';

class Forgotpasswordpage extends StatefulWidget {
  const Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  final emailController1 = TextEditingController();

  

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController1.text.trim());

      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'Password reset link sent! Check your email',
                style: GoogleFonts.oswald(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Image.asset('assets/success1.gif',height: 40,width: 40,),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                e.message.toString(),
                style: GoogleFonts.oswald(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Image.asset('assets/unsuccess1.gif', height: 40,width: 40,),
            );
          });
    }
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
    emailController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "BMI CALCULATOR",
            style: GoogleFonts.oswald(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black,),
          ),
          flexibleSpace: appbar_colour(),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.calculate,
              ),
              onPressed: () {},
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                            height: 20,
                          ),
                    Image.asset(
                      'assets/lock.gif',
                      width: 250,
                      height: 250,
                    ),
                    // Icon(
                    //   Icons.lock,
                    //   color: Colors.black,
                    //   size: 180,
                    // ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                        'HELLO',
                        style: GoogleFonts.oswald(
                          fontSize: 62,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                       SizedBox(
                        height: 5,
                      ),
    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Enter Your Email and we will send you a password reset link',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
    
                    SizedBox(
                      height: 30,
                    ),
                    //email
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        style: textF20(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          filled: true,
                          //fillColor: const Color.fromARGB(255, 148, 136, 136),
                          fillColor: Colors.grey.shade200,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade700,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )),
                          hintText: 'Email Address',
                          hintStyle: textF20(),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value1) {
                          emailController1.text = value1;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
    
                    MaterialButton(
                      onPressed: () {
                        passwordreset();
                      },
                      child: ButtonWidget(
                          backgroundcolor: AppColors.mainColor.withOpacity(0.8),
                          text: "Reset Password",
                          textcolor: Colors.lightBlue),
                    ),
    
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Did you reset the password?',
                          //textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            color: const Color.fromARGB(255, 148, 136, 136),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login now',
                              //textAlign: TextAlign.center,
                              style: GoogleFonts.oswald(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  TextStyle textF20() {
    return GoogleFonts.oswald(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
}
