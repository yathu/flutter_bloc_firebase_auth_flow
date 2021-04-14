import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_repository.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/form_submition_status.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/sign_up/sign_up_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/sign_up/sign_up_event.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/sign_up/sign_up_state.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
              create: (context) => SignUpBloc(
                    authRepo: context.read<AuthRepository>(),
                    authCubit: context.read<AuthCubit>(),
                  ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _signUpForm(),
                  _showLoginButton(context),
                ],
              ))),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // _usernameField(),
                _emailField(),
                _passwordField(),
                _signUpButton(),
              ],
            ),
          )),
    );
  }

  Widget _usernameField() {
    //not need BCZ top already implemented for validation we use BlocBuilder
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Username',
          ),
          validator: (value) => state.isValidUserName
              ? null
              : 'username is invalid', //TODO: create common validator file
          onChanged: (value) => context.read<SignUpBloc>().add(
                SignUpUsernameChanged(username: value),
              ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.mail_outline), hintText: 'Email'),
        validator: (value) => state.isValidEmail ? null : 'Invalid Email',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.https),
          hintText: 'Password',
        ),
        validator: (value) => state.isValidPassword
            ? null
            : 'invalid password', //TODO: create common validator file
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return Container(
        margin: const EdgeInsets.only(top: 60),
        width: double.infinity,
        child: state.formStatus is FormSubmitting
            ? SizedBox(
                width: 50.0,
                height: 50.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
                  }
                },
                child: Text('SignUp')),
      );
    });
  }

  Widget _showLoginButton(BuildContext context) {
    return TextButton(
      child: Text("If you already have account please Login"),
      onPressed: () => context.read<AuthCubit>().showLogin(),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      // backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
