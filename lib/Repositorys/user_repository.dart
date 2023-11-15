import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbmi_app/Models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

//store user in firestore
  createUser(UserModel user) async {
    await _db
        .collection('bmi_data')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
              "Success",
              "Your acount has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
            ))
        // ignore: body_might_complete_normally_catch_error
        .catchError((error, StackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    });
  }

  //fetch all users detals
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('bmi_data').where("email", isEqualTo: user.email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser(String email) async {
    final snapshot = await _db.collection('bmi_data').get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
}
