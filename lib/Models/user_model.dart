// To parse this JSON data, do

//     final bmiData = bmiDataFromJson(jsonString);
// ignore_for_file: unused_import

// import 'package:meta/meta.dart';
// import 'dart:convert';

// BmiData bmiDataFromJson(String str) => BmiData.fromJson(json.decode(str));

// String bmiDataToJson(BmiData data) => json.encode(data.toJson());

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  String name;
  String email;
  final String address;
  final String myAge;
  final String height;
  final String weight;
  final String gender;
  final String bmires;
  final String bmiStatus;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.address,
    required this.myAge,
    required this.height,
    required this.weight,
    required this.gender,
    required this.bmires,
    required this.bmiStatus,
  });

  toJson() {
    return {
      "email": email,
      "name": name,
      "address": address,
      "myAge": myAge,
      "height": height,
      "weight": weight,
      "gender": gender,
      "bmires": bmires,
      "bmiStatus": bmiStatus,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["email"],
      name: data["name"],
      address: data["address"],
      myAge: data["myAge"],
      height: data["height"],
      weight: data["weight"],
      gender: data["gender"],
      bmires: data["bmires"],
      bmiStatus: data["bmiStatus"],
    );
  }
}



 // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['address'] = this.address;
  //   data['myAge'] = this.myAge;
  //   data['height'] = this.height;
  //   data['weight'] = this.weight;
  //   data['gender'] = this.gender;
  //   data['bmires'] = this.bmires;
  //   data['bmiStatus'] = this.bmiStatus;

  //   return data;
  //}





// UserModel.fromJson(Map<String, dynamic> json, this.name, this.address, this.myAge, this.height, this.weight, this.gender, this.bmires, this.bmiStatus) {
//     name = json['name'];
//     address = json['address'];
//     myAge = json['myAge'];
//     bmires = json['bmires'];
//   }







// toJson() {
  //   return {
  //     "name": name,
  //     "address": address,
  //     "myAge": myAge,
  //     "height": height,
  //     "weight": weight,
  //     "gender": gender,
  //     "bmires": bmires,
  //     "bmiStatus": bmiStatus,
  //   };
//above


            // class Player {
            //   String playerName;
            //   int rating;
            //   String timestamp;

            //   Player({this.playerName, this.rating, this.timestamp});

            //   Player.fromJson(Map<String, dynamic> json) {
            //     playerName = json['PlayerName'];
            //     rating = json['Rating'];
            //     timestamp = json['timestamp'];
            //   }

            //   Map<String, dynamic> toJson() {
            //     final Map<String, dynamic> data = new Map<String, dynamic>();
            //     data['PlayerName'] = this.playerName;
            //     data['Rating'] = this.rating;
            //     data['timestamp'] = this.timestamp;
            //     return data;
            //   }
            // }
















  // BmiData copyWith({
  //     String? name,
  //     String? address,
  //     String? myAge,
  //     String? height,
  //     String? weight,
  //     String? gender,
  //     String? bmires,
  //     String? bmiStatus,
  // }) =>
  //     BmiData(
  //         name: name ?? this.name,
  //         address: address ?? this.address,
  //         myAge: myAge ?? this.myAge,
  //         height: height ?? this.height,
  //         weight: weight ?? this.weight,
  //         gender: gender ?? this.gender,
  //         bmires: bmires ?? this.bmires,
  //         bmiStatus: bmiStatus ?? this.bmiStatus,
  //     );

  // factory BmiData.fromJson(Map<String, dynamic> json) => BmiData(
  //     name: json["name"],
  //     address: json["address"],
  //     myAge: json["myAge"],
  //     height: json["height"],
  //     weight: json["weight"],
  //     gender: json["gender"],
  //     bmires: json["bmires"],
  //     bmiStatus: json["bmiStatus"],
  // );

  // Map<String, dynamic> toJson() => {
  //     "name": name,
  //     "address": address,
  //     "myAge": myAge,
  //     "height": height,
  //     "weight": weight,
  //     "gender": gender,
  //     "bmires": bmires,
  //     "bmiStatus": bmiStatus,
  // };

