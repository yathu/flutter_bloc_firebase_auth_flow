import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_navigator.dart';
import 'package:flutter_bloc_firebase_auth_flow/loading_view.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_state.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          //show loading Screen
          if(state is UnKnownSessionState) MaterialPage(child: LoadingView()),

          //show Auth Flow
          if(state is UnAuthenticated)
            MaterialPage(child: BlocProvider(
              create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
              child: AuthNavigator(),
            )
            ),

          //show session flow
          if(state is Authenticated) MaterialPage(child: SessionView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }

}