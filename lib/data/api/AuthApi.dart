import 'package:dio/dio.dart';

class AuthApi {
  late Dio _client;


  Future<void> login() async {
    print("attempting");
    await Future.delayed(Duration(seconds: 3));
    print("logged in");
  }
}