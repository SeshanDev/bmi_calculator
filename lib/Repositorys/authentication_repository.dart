import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newbmi_app/splash_screen.dart';



class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

//variable
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, Splashscreen as WorkerCallback<User?>);
  
  }
  
}