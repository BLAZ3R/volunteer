import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:volunteer/config/Config.dart';
import 'package:volunteer/data/models/Event.dart';

import '../storage/user_secure_storage.dart';

class EventApi {
  Dio _client = Dio();

  Future<List<Event>> getEventsData() async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client.get(
      '${Config.apiUrl}${Config.getEvents}',
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return listEventsFromJson(response.data);
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      throw Exception("ERROR");
    } else
      throw Exception('Ошибка');
  }

  Future<bool> isJoined(int id) async {
    String? token = await UserSecureStorage.getToken();

    _client.options.headers['content-Type'] = 'application/json';
    _client.options.headers["Authorization"] = "$token";

    Response response = await _client.get('${Config.apiUrl}${Config.isJoined}',
        queryParameters: {"id_event": id});

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      print(response.data);

      return response.data;
    } else if (response.statusCode == 401 && response.statusCode == 400) {
      print(response.data);

      throw Exception("ERROR");
    } else
      throw Exception('Ошибка');
  }
}
