import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/auth/register/register_screen.dart';
import 'package:wallet/auth/user_repository.dart';
import 'package:wallet/repositories/user_check_repo.dart';
import 'package:wallet/screens/home_screen.dart';


class UserCheck extends StatelessWidget {
  final FirebaseUser firebaseUser;
  final UserRepo userRepo;
  // In the constructor, require a Todo.
  UserCheck({Key key, @required this.firebaseUser, @required this.userRepo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          user.userCheck(firebaseUser.uid);
          switch (user.userStatus) {
            case UserStatus.Completed:
              return HomeScreen(user: firebaseUser);
            case UserStatus.Uninitialized:
              return CircularProgressIndicator();
            case UserStatus.UnCompleted:
              return RegisterScreen(user: firebaseUser, userRepository: userRepo,);
          }
        },
      ),
    );
  }
}