import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/input_validator.dart';
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
  String _repeatedPassword = '';
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

  void onRegisterNewUserClicked(
      {required Function(String message) showException}) async {
    if (_password == _repeatedPassword) {
      try {
        await _userService.register(_email, _password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          showException('Incorrect email');
        } else if (e.code == 'weak-password') {
          showException('Your password looks weak :(');
        } else {
          showException("Something went wrong!");
        }
      }
    } else {
      showException("Passwords do not match. Check it!");
    }
  }

  void onSignInWithEmailAndPasswordClicked(
      {required Function(String message) showException}) async {
    try {
      await _userService.signInWithEmailAndPassword(_email, _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showException('Incorrect email');
      } else if (e.code == 'channel-error') {
        showException('Fill in all fields!');
      } else {
        showException("Something went wrong!");
      }
    }
  }

  void onSignInWithGoogleClicked() {
    _userService.signWithGoogle();
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

  void updateRepeatedPassword(String value) {
    _repeatedPassword = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void _clearFields() {
    _email = '';
    _password = '';
    _otpCode = '';
    _phoneNumber = '';
    _repeatedPassword = '';
  }
}
