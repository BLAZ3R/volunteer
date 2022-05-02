// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Volunteer userFromJson(String str) => Volunteer.fromJson(json.decode(str));

String userToJson(Volunteer data) => json.encode(data.toJson());

class Volunteer {
  Volunteer({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.dateOfBirthday,
    this.joinedEvents,
    required this.events,
    this.organizationName,
    required this.roles,
  });

  int id;
  String firstName;
  String secondName;
  String email;
  dynamic password;
  String phoneNumber;
  String dateOfBirthday;
  List<dynamic>? joinedEvents;
  List<dynamic>? events;
  dynamic organizationName;
  List<Role> roles;

  factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
        id: json["id"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        dateOfBirthday: json["dateOfBirthday"],
        joinedEvents: json["joinedEvents"] != null
            ? List<dynamic>.from(json["joinedEvents"].map((x) => x))
            : [],
        events: json["events"] != null
            ? List<dynamic>.from(json["events"].map((x) => x))
            : [],
        organizationName: json["organizationName"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "secondName": secondName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "dateOfBirthday": dateOfBirthday,
        "joinedEvents": List<dynamic>.from(joinedEvents!.map((x) => x)),
        "events": List<dynamic>.from(events!.map((x) => x)),
        "organizationName": organizationName,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Role {
  Role({
    required this.id,
    required this.roleName,
  });

  int id;
  String roleName;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
      };
}
