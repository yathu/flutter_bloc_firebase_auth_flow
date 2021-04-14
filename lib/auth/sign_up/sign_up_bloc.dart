import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_credentials.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_repository.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/form_submition_status.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/sign_up/sign_up_event.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({this.authRepo, this.authCubit}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        yield state.copyWith(formStatus: FormSubmitting());

        String token = await authRepo.signUp(email: state.email, password: state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.launchSession(AuthCredentials(
          email: state.email,
          userId: token
        ));

        // authCubit.showConfirmSignUp(
        //   email: state.email,
        //   password: state.password,
        // );

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }
}
