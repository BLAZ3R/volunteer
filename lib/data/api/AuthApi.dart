import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:volunteer/config/Config.dart';
import 'package:volunteer/data/models/LoginRequest.dart';
import 'package:volunteer/data/storage/user_secure_storage.dart';

import '../models/User.dart';

class AuthApi {
  late Dio _client = Dio();

  Future<bool> login(LoginRequest loginRequest) async {
    Response response = await _client.post('${Config.apiUrl}${Config.login}',
        data: loginRequest.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      await UserSecureStorage.setToken(response.data);
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception("Неправильная почта или пароль");
    } else
      throw Exception('Ошибка');
  }

  Future<bool> createVolunteer(User user) async {
    Response response = await _client
        .post('${Config.apiUrl}${Config.createVolunteer}', data: user.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception(response.statusMessage);
    } else
      throw Exception('Ошибка');
  }

  Future<bool> createOrganization(User user) async {
    Response response = await _client
        .post('${Config.apiUrl}${Config.createOrganizer}', data: user.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception(response.statusMessage);
    } else
      throw Exception('Ошибка');
  }
}
