import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallet/auth/register/register_validator.dart';
import 'package:wallet/auth/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepo _userRepository;

  RegisterBloc({@required UserRepo userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();
  @override
  Stream<RegisterState> transform(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! FirstNameChanged && event is! LastNameChanged && event is! PhoneNumChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is FirstNameChanged || event is LastNameChanged || event is PhoneNumChanged);
    }).debounceTime(Duration(milliseconds: 100));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is FirstNameChanged) {
      yield* _mapFirstNameChangedToState(event.firstName);
    } else if (event is LastNameChanged) {
      yield* _mapLastNameChangedToState(event.lastName);
    }
    else if (event is PhoneNumChanged) {
      yield* _mapPhoneNumChangedToState(event.phoneNum);
    }
      else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.firstName, event.lastName, event.phoneNum, event.uid);
    }
  }
  Stream<RegisterState> _mapFirstNameChangedToState(String firstName) async* {
    yield currentState.update(
      isFirstNameValid: RegisterValidators.isFirstNameValid(firstName),
    );
  }

  Stream<RegisterState> _mapLastNameChangedToState(String lastName) async* {
    yield currentState.update(
      isLastNameValid: RegisterValidators.isLastNameValid(lastName),
    );
  }

  Stream<RegisterState> _mapPhoneNumChangedToState(String phoneNum) async* {
    yield currentState.update(
      isPhoneNumValid: RegisterValidators.isPhoneNumValid(phoneNum),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String firstName,
    String lastName,
    String phoneNum,
    String uid
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        firstName: firstName,
        lastName: lastName,
        phoneNum: phoneNum,
        uid: uid
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}