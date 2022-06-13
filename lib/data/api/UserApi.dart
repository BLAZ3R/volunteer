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

  Future<List<Volunteer>> getOrganisers() async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client.get(
      '${Config.apiUrl}${Config.getOrganisers}',
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // await UserSecureStorage.setToken(response.data);
      return listFromJson(response.data);
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception("ERROR");
    } else
      throw Exception('Ошибка');
  }

  Future<bool> changePhoto(String base64) async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Map<String, dynamic> toJson() => {
          "image": base64,
        };

    Response response = await _client.post(
      '${Config.apiUrl}${Config.changePhoto}',
      data: toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // await UserSecureStorage.setToken(response.data);
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception("ERROR");
    } else
      throw Exception('Ошибка');
  }

  Future<bool> changeUser(User user) async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client.post(
      '${Config.apiUrl}${Config.changeUser}',
      data: user.toJson(),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print(response.data);
      // await UserSecureStorage.setToken(response.data);
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      print(response.data);
      throw Exception("ERROR");
    } else
      print(response.data);

    throw Exception('Ошибка');
  }

  Future<bool> joinEvent(int id) async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client
        .post('${Config.apiUrl}${Config.joinEvent}', queryParameters: {
      "id_event": id,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print(response.data);
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      print(response.data);

      throw Exception("ERROR");
    } else
      print(response.data);

    throw Exception('Ошибка');
  }

  Future<bool> leaveEvent(int id) async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client
        .post('${Config.apiUrl}${Config.leaveEvent}', queryParameters: {
      "id_event": id,
    });
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print(response.data);
      return true;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      print(response.data);

      throw Exception("ERROR");
    } else
      print(response.data);

    throw Exception('Ошибка');
  }
}
