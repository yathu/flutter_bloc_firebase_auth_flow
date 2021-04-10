import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_cubit.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/auth_repository.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/confirm/confirmation_bloc.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/confirm/confirmation_event.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/confirm/confirmation_state.dart';
import 'package:flutter_bloc_firebase_auth_flow/auth/form_submition_status.dart';

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) =>
            ConfirmationBloc(authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _confirmationForm(),
          ],
        )
      )),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
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
                _confirmCodeField(),
                _confirmButton(),
              ],
            ),
          )),
    );
  }

  Widget _confirmCodeField() {
    //not need BCZ top already implemented for validation we use BlocBuilder
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.https),
            hintText: 'Confirmation code',
          ),
          validator: (value) => state.isValidConfirmationCode
              ? null
              : 'Code is invalid', //TODO: create common validator file
          onChanged: (value) => context.read<ConfirmationBloc>().add(
                ConfirmationCodeChanged(confirmation_code: value),
              ),
        );
      },
    );
  }
  

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(builder: (context, state) {
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
                    context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
                  }
                },
                child: Text('Confirm')),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      // backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
