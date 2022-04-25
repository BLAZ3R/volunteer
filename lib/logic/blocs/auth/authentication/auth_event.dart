import 'package:meta/meta.dart';

import '../../../../data/models/User.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

// Fired just after the app is launched
class AppLoaded extends AuthenticationEvent {}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({required this.user});
}

// Fired when the user has logged out
class UserLoggedOut extends AuthenticationEvent {}
