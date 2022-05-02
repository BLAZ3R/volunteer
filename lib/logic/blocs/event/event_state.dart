import 'package:equatable/equatable.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoadInProgress extends EventState {}

class EventLoadSuccess extends EventState {}

class EventLoadFailure extends EventState {
  final String errorMessage;
  const EventLoadFailure({required this.errorMessage});
}
