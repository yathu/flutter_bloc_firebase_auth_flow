import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_credentials.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_cubit.dart';

enum AuthState { login, signUP, confirmSignUP }

class AuthCubit extends Cubit<AuthState> {
  SessionCubit sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);

  void showSignUP() => emit(AuthState.signUP);

  void showConfirmSignUp({
    String email,
    String password,
  }) {
    credentials =
        AuthCredentials(password: password, email: email);

    emit(AuthState.confirmSignUP);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
