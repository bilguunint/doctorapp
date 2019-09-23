import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/auth/login/login_form.dart';
import 'package:wallet/auth/user_repository.dart';
import 'package:wallet/bloc/login_bloc/bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepo _userRepository;

  LoginScreen({Key key, @required UserRepo userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}