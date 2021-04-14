import 'package:flutter_bloc_firebase_auth_flow/auth/form_submition_status.dart';

class SignUpState {
  final String username;
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidUserName => username.length > 3;
  bool get isValidEmail => email.length > 3;
  bool get isValidPassword => password.length > 6;

  SignUpState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith(
      {String username,
      String email,
      String password,
      FormSubmissionStatus formStatus}) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
