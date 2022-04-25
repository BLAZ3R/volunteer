// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.dateOfBirthday,
  });

  String firstName;
  String secondName;
  String email;
  String password;
  String phoneNumber;
  String dateOfBirthday;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        secondName: json["secondName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        dateOfBirthday: json["dateOfBirthday"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "secondName": secondName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "dateOfBirthday": dateOfBirthday,
      };
}
