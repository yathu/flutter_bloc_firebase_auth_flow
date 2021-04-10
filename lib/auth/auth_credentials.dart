import 'package:flutter/cupertino.dart';

class AuthCredentials {
  final String username;
  final String password;
  final String email;
  String userId;

  AuthCredentials({@required this.username, this.email, this.password, this.userId});
}
