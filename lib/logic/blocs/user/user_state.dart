import 'package:equatable/equatable.dart';
import 'package:volunteer/data/models/Volunteer.dart';

import '../../../data/models/User.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UserState {}

class UsersLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final Volunteer user;

  const UserLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class UsersLoadSuccess extends UserState {
  final List<Volunteer> users;
  const UsersLoadSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

class UserLoadFailure extends UserState {
  final String errorMessage;
  const UserLoadFailure({required this.errorMessage});
}
