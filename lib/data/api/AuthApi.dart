import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:volunteer/config/Config.dart';
import 'package:volunteer/data/models/LoginRequest.dart';

import '../models/User.dart';

class AuthApi {
  late Dio _client = Dio();

  Future<bool> login(LoginRequest loginRequest) async {
    Response response = await _client.post('${Config.apiUrl}${Config.login}',
        data: loginRequest.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.data);
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception("Неправильная почта или пароль");
    } else
      throw Exception('Ошибка');
  }
}
