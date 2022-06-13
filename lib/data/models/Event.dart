// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

import 'package:volunteer/data/models/Volunteer.dart';

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Event> listEventsFromJson(List<dynamic> list) =>
    List<Event>.from(list.map((e) => Event.fromJson(e)));

class Event {
  Event({
    required this.id,
    required this.name,
    required this.city,
    required this.date,
    required this.time,
    required this.amountOfVolunteer,
    required this.description,
    required this.image,
    required this.organizer,
    required this.participants,
    required this.lat,
    required this.lng,
    required this.finished,
  });

  int id;
  String name;
  String city;
  String date;
  String time;
  int amountOfVolunteer;
  String description;
  String image;
  double lat;
  double lng;
  Organizer organizer;
  List<Volunteer> participants;
  bool finished;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        date: json["date"],
        time: json["time"],
        amountOfVolunteer: json["amountOfVolunteer"],
        description: json["description"],
        image: json["image"],
        organizer: Organizer.fromJson(json["organizer"]),
        participants: listFromJson(json['participants']),
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        finished: json["finished"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "date": date,
        "time": time,
        "amountOfVolunteer": amountOfVolunteer,
        "description": description,
        "image": image,
        "organizer": organizer.toJson(),
        "participants": List<dynamic>.from(participants.map((x) => x)),
        "finished": finished,
      };
}

class Organizer {
  Organizer({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.dateOfBirthday,
    required this.image,
    required this.organizationName,
    required this.roles,
  });

  int id;
  String firstName;
  String secondName;
  String email;
  String password;
  String phoneNumber;
  String dateOfBirthday;
  String image;
  String organizationName;
  List<Role> roles;

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
        id: json["id"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        dateOfBirthday: json["dateOfBirthday"],
        image: json["image"],
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
        "image": image,
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
