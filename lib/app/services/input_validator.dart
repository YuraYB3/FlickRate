class InputValidator {
  bool isEmailValid(String value) {
    return value.isNotEmpty;
  }

  bool isPasswordValid(String value) {
    return value.isNotEmpty;
  }

  bool isNumberValid(String value) {
    return value.length == 9;
  }

  bool isOtpValid(String value) {
    return value.length == 6;
  }
}
