import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:volunteer/config/Config.dart';
import 'package:volunteer/data/models/LoginRequest.dart';
import 'package:volunteer/data/storage/user_secure_storage.dart';

import '../models/User.dart';
import '../models/Volunteer.dart';

class UserApi {
  Dio _client = Dio();

  Future<Volunteer> getUserData() async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client.get(
      '${Config.apiUrl}${Config.getUser}',
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // await UserSecureStorage.setToken(response.data);
      return Volunteer.fromJson(response.data);
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception("ERROR");
    } else
      throw Exception('Ошибка');
  }
}
