// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

LoginRequest userFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String userToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
