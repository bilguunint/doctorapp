import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/auth/register/register.dart';
import 'package:wallet/auth/user_repository.dart';
import 'package:wallet/bloc/register_bloc/bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepo _userRepository;
  final FirebaseUser user;

  RegisterScreen({Key key, @required UserRepo userRepository, @required this.user})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(user: user),
        ),
      ),
    );
  }
}