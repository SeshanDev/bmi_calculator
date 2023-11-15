// ignore_for_file: duplicate_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newbmi_app/pages/inputdatapage.dart';
import 'package:newbmi_app/pages/showpreviousdata.dart';
import 'package:newbmi_app/reusable/app_colors.dart';
import 'package:newbmi_app/reusable/appbar_titles.dart';
import 'package:newbmi_app/widgets/button_widget.dart';

//import 'package:newbmi_app/pages/Navbar.dart';

class Registerpage extends StatefulWidget {
  final VoidCallback showloginscreen;
  const Registerpage({super.key, required this.showloginscreen});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  //controller
  final emailController1 = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  bool passToggle = true;

//formkey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//variables to store data
  var emailAddress;
  var Password;
  var confirmpassword;

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
    passwordController.dispose();
    confirmpasswordController.dispose();
    nameController.dispose();
    addressController.dispose();
    emailController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  //create a register fuction
  Future register() async {
    if (passwordConfirmed()) {
      if (_formKey.currentState!.validate()) {
        print('im in');
        print(emailController1.text);
        print(passwordController.text);
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController1.text.trim(),
              password: passwordController.text.trim());

          //add user details
          adduserdetails(
              nameController.text.trim(),
              addressController.text.trim(),
              emailController1.text.trim(),
              passwordController.text.trim());

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FirstPage()));
          deletedata();

          return showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  // backgroundColor:
                  //     Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
                  title: Text(
                    'Your account create successfull !',
                    style: GoogleFonts.oswald(
                        fontSize: 15, fontWeight: FontWeight.bold),
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
                  //       onPressed: () {
                  //       }),
                  // ],
                );
              });
        } on FirebaseAuthException catch (error) {
          print(error);
          showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  // backgroundColor:
                  //     Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
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
    }
  }

  Future adduserdetails(
      String name, String address, String email, String password) async {
    // var document = UserModel(
    // address: address,
    // bmiStatus: '',
    // bmires: '',
    // gender: '',
    // height: '',
    // myAge: '',
    // name: name,
    // weight: '');
    await FirebaseFirestore.instance.collection('bmi_data').add({
      'name': name,
      'address': address,
      'email': email,
      'password': password,
      'myAge': '0 years, 0 months and 0 days',
      'height': '150',
      'weight': '50',
      'gender': 'Male',
      'bmires': '22.22',
      'bmiStatus': 'Normal',
    });
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'address': address,
      'email': email,
      'password': password,
    });
  }

  deletedata() async {
    final collection =
        await FirebaseFirestore.instance.collection("bmi_data").get();
    //final batch = FirebaseFirestore.instance.get();
    //  print(collection.docs.toString() + 'hellooooo');
    for (final doc in collection.docs) {
      if (doc.data()['email'].toString() ==
          FirebaseAuth.instance.currentUser!.email) {
        //print('fffff');
        doc.reference.delete();
        // doc.data()['email'].
        // batch.delete(doc.reference);
      }
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              // backgroundColor:
              //     Color.fromARGB(255, 207, 202, 202).withOpacity(0.8),
              title: Text(
                "Password dosen't match. please check your password",
                style: GoogleFonts.oswald(
                    fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      //resizeToAvoidBottomInset: false,
      // drawer: NavBar(),
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
              Icons.login_outlined,
            ),
            onPressed: () {
              Navigator.pop(context);
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
              //  decoration: BoxDecoration(
              //         gradient: LinearGradient(colors: [
              //           Colors.white,
              //            Colors.black,
              //           Colors.grey,
              //           Colors.grey,
              //           Colors.white

              //         ],begin: Alignment.topCenter, end: Alignment.bottomCenter
              //         ),
              //       ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),

                      Image.asset(
                        'assets/lock.gif',
                        height: 150,
                        width: 150,
                      ),
                      // Icon(
                      //   Icons.lock,
                      //   color: Colors.black,
                      //   size: 120,
                      // ),
                      SizedBox(
                        height: 40,
                      ),

                      Text(
                        'HELLO THERE',
                        style: GoogleFonts.oswald(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Text('Register below with your details!',
                          style: GoogleFonts.oswald(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )),

                      SizedBox(
                        height: 25,
                      ),

                      //name
                      TextFormField(
                        validator: validatename,
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
                          hintText: 'Name',
                          hintStyle: GoogleFonts.oswald(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value1) {
                          nameController.text = value1;
                        },
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //address
                      TextFormField(
                        validator: validateaddress,
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
                          hintText: 'Address',
                          hintStyle: GoogleFonts.oswald(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.location_city_outlined,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value1) {
                          addressController.text = value1;
                        },
                        onSaved: (value) {
                          addressController.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //email
                      TextFormField(
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
                        onChanged: (value1) {
                          emailController1.text = value1;
                        },
                        onSaved: (value) {
                          //emailController1.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //password
                      TextFormField(
                        validator: validatepassword,
                        // validator: (value) {
                        //   confirmpassword = value;
                        //   if (value!.isEmpty) {
                        //     return "Please Enter New Password";
                        //   } else if (value.length < 4) {
                        //     return "Password must be atleast 8 characters long";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        obscureText: passToggle,
                        style: GoogleFonts.oswald(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                           contentPadding:EdgeInsets.only(right: 15,),
                          //contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                          hintText: 'Create A New Password',
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
                      SizedBox(
                        height: 10,
                      ),

                      //confirm password

                      TextFormField(
                        validator: validateconfirmpassword,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please Re-Enter New Password";
                        //   } else if (value.length < 4) {
                        //     return "Password must be atleast 8 characters long";
                        //   } else if (value != confirmpassword) {
                        //     return "Password must be same as above";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        obscureText: passToggle,
                        style: GoogleFonts.oswald(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                           contentPadding:EdgeInsets.only(right: 15,),
                          //contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                          hintText: 'Confirm Password',
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
                        controller: confirmpasswordController,
                        onSaved: (value) {
                          confirmpassword = value;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      MaterialButton(
                        onPressed: () {
                          //call the register function
                          if (_formKey.currentState!.validate()) {
                            // do the API call here
                            register();
                          }
                          //register();
                          print('click');
                        },
                        child: ButtonWidget(
                            backgroundcolor:
                                AppColors.mainColor.withOpacity(0.8),
                            text: "Register",
                            textcolor: Colors.black),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Allready have a account?',
                            style: GoogleFonts.oswald(
                              color: const Color.fromARGB(255, 148, 136, 136),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('Login now',
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

String? validatename(String? formname) {
  if (formname == null || formname.isEmpty) return 'Name is required';

  return null;
}

String? validateaddress(String? formaddress) {
  if (formaddress == null || formaddress.isEmpty) return 'Address is required.';

  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'Email address is required.';

  return null;
}

String? validatepassword(String? formpassword) {
  if (formpassword == null || formpassword.isEmpty)
    return 'Password is required.';
  else if (formpassword.length < 5) {
    return "Password must be atleast 6 characters long";
  }

  return null;
}

String? validateconfirmpassword(String? formconfirmpassword) {
  if (formconfirmpassword == null || formconfirmpassword.isEmpty)
    return 'Password is required.';

  return null;
}
