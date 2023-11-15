import 'package:get/get.dart';
import 'package:newbmi_app/Repositorys/authentication_repository.dart';
import 'package:newbmi_app/Repositorys/user_repository.dart';



class Prfilecontroller extends GetxController {
  static Prfilecontroller get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

//get user email and pass to userRepository to fentch record
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }
}
