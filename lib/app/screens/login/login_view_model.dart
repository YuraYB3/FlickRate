import 'package:flutter/material.dart';

import '../../services/input/input_validator.dart';
import '../../services/user/iuser_service.dart';

enum LoginState {
  loginWithPhoneNumber,
  loginWithEmailAndPassword,
  registerNewAccount
}

class LoginViewModel extends ChangeNotifier {
  final InputValidator _inputValidator = InputValidator();
  final IUserService _userService;
  String _phoneNumber = '';
  String _otpCode = '';
  String _email = '';
  String _password = '';
  bool isOtpSent = false;
  LoginState loginMethod = LoginState.loginWithEmailAndPassword;

  String get phoneNumber => _phoneNumber;
  String get otpCode => _otpCode;
  String get email => _email;
  String get password => _password;
  LoginViewModel({required IUserService userService})
      : _userService = userService;

  void sentOtpClicked({required Function(String message) showException}) async {
    bool isValid = _inputValidator.isNumberValid(_phoneNumber);
    if (isValid) {
      try {
        await _userService.sentOtp(_phoneNumber);
        isOtpSent = true;
        notifyListeners();
      } catch (e) {
        showException(e.toString());
      }
    } else {
      showException('Incorrect phone number');
    }
  }

  void onSwitchToPhoneNumberClicked() {
    loginMethod = LoginState.loginWithPhoneNumber;
    notifyListeners();
    _clearFields();
  }

  void onSwitchToSignUpClicked() {
    loginMethod = LoginState.registerNewAccount;
    notifyListeners();
    _clearFields();
  }

  void onSwitchToEmailAndPasswordClicked() {
    loginMethod = LoginState.loginWithEmailAndPassword;
    notifyListeners();
    _clearFields();
  }

  void onApplyOtpCodeButtonClicked(
      {required Function(String message) showException}) async {
    bool isValid = _inputValidator.isOtpValid(_otpCode);
    if (isValid) {
      try {
        await _userService.signWithOtp(_otpCode);
      } catch (e) {
        showException("Incorrect code. Please try again");
      }
    } else {
      showException('Code must have 6 numbers');
    }
  }

  void onRegisterNewUserClicked() {
    _userService.register(email, password);
  }

  void updatePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void updateOtpCode(String value) {
    _otpCode = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void onSignInWithGoogleClicked() {
    _userService.signWithGoogle();
  }

  void onSignInWithEmailAndPasswordClicked() {
    _userService.signInWithEmailAndPassword(email, password);
  }

  void _clearFields() {
    _email = '';
    _password = '';
    _otpCode = '';
    _phoneNumber = '';
  }
}
