import 'package:flutter_bloc_firebase_auth_flow/auth/form_submition_status.dart';

class LoginState{
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidEmail => email.length > 3;
  bool get isValidPassword => password.length > 6;

  LoginState({
    this.email='',
    this.password='',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String username,
    String password,
    FormSubmissionStatus formStatus, String email
  }){
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}