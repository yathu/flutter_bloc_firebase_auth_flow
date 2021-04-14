import 'package:flutter/foundation.dart';

abstract class SessionState {}

class UnKnownSessionState extends SessionState {}

class UnAuthenticated extends SessionState {}

class Authenticated extends SessionState {
  final dynamic user;
  Authenticated({@required this.user});

  String get getUser {
    return user;
  }
}
