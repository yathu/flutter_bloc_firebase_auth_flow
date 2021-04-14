import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_credentials.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_repository.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/form_submition_status.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/login/login_event.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    //username updated
    if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);

      //password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      //form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final token = await authRepo.signWithCredentials(
            email: state.email, password: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.launchSession(AuthCredentials(
          email: state.email,
          userId: token,
        ));
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
