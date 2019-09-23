import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}
class FirstNameChanged extends RegisterEvent {
  final String firstName;

  FirstNameChanged({@required this.firstName}) : super([firstName]);

  @override
  String toString() => 'FirstNameChanged { firstName :$firstName }';
}

class LastNameChanged extends RegisterEvent {
  final String lastName;

  LastNameChanged({@required this.lastName}) : super([lastName]);

  @override
  String toString() => 'LastNameChanged { lastName: $lastName }';
}

class PhoneNumChanged extends RegisterEvent {
  final String phoneNum;

  PhoneNumChanged({@required this.phoneNum}) : super([phoneNum]);

  @override
  String toString() => 'PhoneNumChanged { phoneNum: $phoneNum }';
}

class Submitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String phoneNum;
  final String uid;

  Submitted({@required this.firstName, @required this.lastName, @required this.phoneNum, @required this.uid})
      : super([firstName, lastName, phoneNum, uid]);

  @override
  String toString() {
    return 'Submitted { firstName: $firstName, lastName: $lastName }';
  }
}