import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/auth/login/login_screen.dart';
import 'package:wallet/screens/user_check.dart';
import 'auth/simple_bloc_delegate.dart';
import 'auth/splash_screen.dart';
import 'auth/user_repository.dart';
import 'bloc/auth_bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepo userRepository = UserRepo();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepo _userRepository;

  App({Key key, @required UserRepo userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Rubik'),
      home: BlocBuilder(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
              return UserCheck(firebaseUser: state.user, userRepo: _userRepository,);
            }
        },
      ),
    );
  }
}