import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/auth/Forgot_pw_page.dart';
import 'package:newbmi_app/auth/Register_page.dart';
import 'package:newbmi_app/pages/Navbar.dart';
import 'package:newbmi_app/pages/showpreviousdata.dart';
import 'package:newbmi_app/reusable/app_colors.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/reusable/dialog_box.dart';
import 'package:newbmi_app/widgets/button_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool passToggle = true;

//formkey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//variables to store data
  var emailAddress;

  var Password;

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

  @override
  Widget build(BuildContext context) {
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
        //backgroundColor: Colors.grey[300],
        //resizeToAvoidBottomInset: false,
        drawer: NavBar(),
        appBar: AppBar(
          title: Text(
            "BMI CALCULATOR",
            style: GoogleFonts.oswald(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          flexibleSpace: appbar_colour(),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.app_registration,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Registerpage(
                            showloginscreen: () {},
                          )),
                );
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
                //   gradient: LinearGradient(colors: [
                //     Colors.white,
                //      Colors.grey,
                //     Colors.black,
                //     Colors.grey,
                //     Colors.white,

                //   ],begin: Alignment.topCenter, end: Alignment.bottomCenter
                //   ),
                // ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/lock.gif',
                        width: 250,
                        height: 200,
                      ),
                      // Icon(
                      //   Icons.lock,
                      //   color: Colors.black,
                      //   size: 180,
                      // ),
                      SizedBox(
                        height: 70,
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

                      Text("Welcome back You've been missed!",
                          style: GoogleFonts.oswald(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )),

                      SizedBox(
                        height: 40,
                      ),

                      //email
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          validator: validateEmail,
                          style: GoogleFonts.oswald(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            filled: true,
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
                            hintStyle: GoogleFonts.oswald(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                          onSaved: (value) {
                            emailAddress = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //password
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          validator: validatepassword,
                          obscureText: passToggle,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.oswald(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            contentPadding:EdgeInsets.only(right: 15,),
                            //contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                            filled: true,
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
                            hintText: 'Password',
                            hintStyle: GoogleFonts.oswald(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(
                                passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          controller: passwordController,
                          onSaved: (value) {
                            Password = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Forgotpasswordpage();
                                }));
                              },
                              child: Text('Forgot password?',
                                  style: GoogleFonts.oswald(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
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
                            _formKey.currentState!.save();

                            print(emailAddress);
                            print(Password);

                            //call the login function
                            logIn();
                          }
                        },
                        child: ButtonWidget(
                            backgroundcolor:
                                AppColors.mainColor.withOpacity(0.8),
                            text: "Login",
                            textcolor: Colors.black),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a user?',
                            style: GoogleFonts.oswald(
                              color: const Color.fromARGB(255, 148, 136, 136),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            //onTap:() => showRegisterPage,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registerpage(
                                          showloginscreen: () {},
                                        )),
                              );
                            },
                            child: Text('Register now',
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
        ),
      ),
    );
  }

  //create a login fuction
  void logIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: Password,
        );
        print(FirebaseAuth.instance.currentUser!.email);
        return showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                insetAnimationCurve: Curves.bounceOut,
                insetAnimationDuration: Duration(seconds: 10),
                title: Text(
                  'Login successfull !',
                  style: GoogleFonts.oswald(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Image.asset(
                  'assets/success1.gif',
                  height: 40,
                  width: 40,
                ),
              );
            });
      } on FirebaseAuthException catch (error) {
        //print(error);
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  error.message.toString(),
                  style: GoogleFonts.oswald(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                content: Image.asset(
                  'assets/unsuccess1.gif',
                  height: 40,
                  width: 40,
                ),
              );
            });
      }
    }

    // showDialog(
    //     context: context,
    //     builder: (BuildContext ctx) {
    //       return const AlertDialog(
    //         backgroundColor: Colors.green,
    //         //title: Text('Alert'),
    //         content: Text(
    //           'Login Successfull',
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    // actions: [
    //   ElevatedButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       child: Text('OK')),

    // ],
    //   );
    // });
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

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Email address is required.';

  return null;
}

String? validatepassword(String? formpassword) {
  if (formpassword == null || formpassword.isEmpty)
    return 'Password is required.';

  return null;
}
