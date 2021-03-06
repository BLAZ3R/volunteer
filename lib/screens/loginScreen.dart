import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:volunteer/components/RoundedButton.dart';
import 'package:volunteer/components/TextFieldContainer.dart';

import 'package:volunteer/data/api/AuthApi.dart';
import 'package:volunteer/logic/blocs/auth/login/login_bloc.dart';
import 'package:volunteer/logic/blocs/auth/login/login_event.dart';
import 'package:volunteer/logic/blocs/auth/login/login_state.dart';
import 'package:volunteer/logic/util/util.dart';
import 'package:volunteer/screens/navbarScreen.dart';
import 'package:volunteer/screens/profileScreen.dart';

import '../constants/MainTheme.dart';
import 'signUpScreen.dart';
import '../logic/blocs/form_submission_status.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthApi>(),
        ),
        child: _loginForm(size),
      ),
    );
  }

  Widget _loginForm(Size size) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;

          if (formStatus is SubmissionSuccess) {
            Phoenix.rebirth(context);
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _emailField(),
                  _passwordField(),
                  _loginButton(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "?????????????? ??????????????",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFieldContainer(
        child: TextFormField(
          validator: (value) =>
              state.isValidEmail ? null : '?????????? ?????????????? ????????????????',
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginEmailChanged(email: value),
              ),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            hintText: "??????????",
          ),
          style: MainTheme.of(context).bodyText1,
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFieldContainer(
        child: TextFormField(
          validator: (value) =>
              state.isValidPassword ? null : '???????????? ?????????????? ????????????????',
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password: value),
              ),
          obscureText: _passwordVisible,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            hintText: "????????????",
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: MainTheme.of(context).primaryText,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          style: MainTheme.of(context).bodyText1,
        ),
      );
    });
  }

  Widget _loginButton(Size size) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      final formStatus = state.formStatus;

      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ElevatedButton(
            child: Text(
              "??????????",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginSubmitted());
              }

              if (formStatus is SubmissionFailed) {
                showSnackbar(context, formStatus.exception.toString());
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: MainTheme.of(context).title2),
          ),
        ),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
