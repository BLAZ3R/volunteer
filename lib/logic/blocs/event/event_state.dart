import 'package:equatable/equatable.dart';
import 'package:volunteer/data/models/Event.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoadInProgress extends EventState {}

class EventLoadSuccess extends EventState {
  final List<Event> events;
  const EventLoadSuccess({required this.events});

  @override
  List<Object> get props => [events];
}

class EventLoadFailure extends EventState {
  final String errorMessage;
  const EventLoadFailure({required this.errorMessage});
}
