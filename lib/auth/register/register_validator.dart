class RegisterValidators {
  

  static isFirstNameValid(String firstName) {
    return firstName.isNotEmpty;
  }

  static isLastNameValid(String lastName) {
    return lastName.isNotEmpty;
  }

  static isPhoneNumValid(String phoneNum) {
    return phoneNum.isNotEmpty && phoneNum.length == 8;
  }

}