import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/confirm/confirmation_view.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/login/login_view.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/sign_up/sign_up_view.dart';

class AuthNavigator extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthState>(builder: (context,state){
      return Navigator(
        pages: [
          if (state == AuthState.login) MaterialPage(child: LoginView()),

          if(state == AuthState.signUP ||
              state == AuthState.confirmSignUP) ...[
            MaterialPage(child: SignUpView()),

            if(state == AuthState.confirmSignUP)
              MaterialPage(child: ConfirmationView())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }

}