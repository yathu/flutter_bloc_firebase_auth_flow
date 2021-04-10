import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_credentials.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_repository.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_state.dart';

class SessionCubit extends Cubit<SessionState>{
  final AuthRepository authRepository;

  SessionCubit({this.authRepository}) : super(UnKnownSessionState()){
    attemptAutoLogin();
  }

  void attemptAutoLogin() async{
    try{
      final userId = await authRepository.attemptAutoLogin();
      //final user = dataRepo.getUser(userID);
      final user = userId;
      emit(Authenticated(user: user));

    } on Exception {
      emit(UnAuthenticated());
    }
  }

  void showAuth() => emit(UnAuthenticated());

  void showSession(AuthCredentials credentials){
    //final user = dataRepo.getUser(credentials.userId);
    final user = credentials.username;
    emit(Authenticated(user: user));
  }

  void signOut(){
    authRepository.signOut();
    emit(UnAuthenticated());
  }
}