import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:wallet/model/user.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}
class Completed extends AuthenticationState {
  final User user;

  Completed(this.user) : super([user]);
  @override
  String toString() => 'Completed { user: $user }';
}
class UnCompleted extends AuthenticationState {
  final FirebaseUser firebaseUser;
  UnCompleted(this.firebaseUser) : super([firebaseUser]);
  @override
  String toString() => 'UnCompleted { user: $firebaseUser }';
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final FirebaseUser user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => 'Authenticated { displayName: $user }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}