import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volunteer/data/storage/user_secure_storage.dart';

import 'user_event.dart';
import 'package:volunteer/data/api/UserApi.dart';
import 'package:volunteer/logic/blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserApi userApi})
      : assert(userApi != null),
        _userApi = userApi,
        super(UsersLoadInProgress());

  final UserApi _userApi;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetched) {
      yield UsersLoadInProgress();
      try {
        final response = await _userApi.getUserData();
        yield UserLoadSuccess(user: response);
      } catch (e) {
        yield UserLoadFailure(errorMessage: e.toString());
      }
    } else if (event is OrganizersFetched) {
      yield UsersLoadInProgress();
      try {
        final response = await _userApi.getOrganisers();
        yield UsersLoadSuccess(users: response);
      } catch (e) {
        yield UserLoadFailure(errorMessage: e.toString());
      }
    }
  }

  // Future<void> changeProfile(
  //   String email,
  //   String name,
  // ) async {
  //   try {
  //     final dynamic data = (await _qfitApiRepository.changeProfile(
  //       email,
  //       name,
  //     ));
  //     await Future.wait([
  //       if (data['email'] != null)
  //         sharedPreferences.setString("email", data['email']),
  //       if (data['name'] != null)
  //         sharedPreferences.setString("name", data['name']),
  //     ]);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
