import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/session_state.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
              if (state is Authenticated) {
                return Text(state.user);
              } else {
                return Text('Authentication flow error');
              }
            }),
            TextButton(
                onPressed: () =>
                    BlocProvider.of<SessionCubit>(context).signOut(),
                child: Text('Sign out')),
          ],
        ),
      ),
    );
  }
}
