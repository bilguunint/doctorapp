import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isPhoneNumValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isFirstNameValid && isLastNameValid && isPhoneNumValid;

  RegisterState({
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isPhoneNumValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isPhoneNumValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isPhoneNumValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isPhoneNumValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isPhoneNumValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  RegisterState update({
    bool isFirstNameValid,
  bool isLastNameValid,
  bool isPhoneNumValid,
  }) {
    return copyWith(
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isPhoneNumValid: isPhoneNumValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isFirstNameValid,
  bool isLastNameValid,
  bool isPhoneNumValid,
  bool isSubmitting,
  bool isSuccess,
  bool isFailure,
  }) {
    return RegisterState(
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isPhoneNumValid: isPhoneNumValid ?? this.isPhoneNumValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isFirstNameValid: $isFirstNameValid,
      isLastNameValid: $isLastNameValid, 
      isPhoneNumValid: $isPhoneNumValid,     
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}