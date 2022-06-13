import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volunteer/data/api/EventApi.dart';
import 'package:volunteer/data/storage/user_secure_storage.dart';
import 'package:volunteer/logic/blocs/event/event_event.dart';
import 'package:volunteer/logic/blocs/event/event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({required EventApi eventApi})
      : assert(eventApi != null),
        _eventApi = eventApi,
        super(EventLoadInProgress());

  final EventApi _eventApi;

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is EventFetched) {
      yield EventLoadInProgress();
      try {
        final response = await _eventApi.getEventsData();
        yield EventLoadSuccess(events: response);
      } catch (e) {
        yield EventLoadFailure(errorMessage: e.toString());
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
