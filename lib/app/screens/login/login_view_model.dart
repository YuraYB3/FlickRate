import 'package:flickrate/app/services/input_validator.dart';
import 'package:flickrate/app/services/local_storage/keys.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flutter/material.dart';
import '../../../domain/auth/iauth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final IAuthService _authService;
  final InputValidator _inputValidator = InputValidator();
  final ILocalStorage _localStorage;
  String _phoneNumber = '';
  String _otpCode = '';
  bool isOtpSent = false;
  bool isLoginWithNumberClicked = false;

  String get phoneNumber => _phoneNumber;
  String get otpCode => _otpCode;
  LoginViewModel(
      {required ILocalStorage localStorage, required IAuthService authService})
      : _authService = authService,
        _localStorage = localStorage;

  void sentOtpClicked({required Function(String message) showException}) async {
    bool isValid = _inputValidator.isNumberValid(_phoneNumber);
    if (isValid) {
      try {
        await _authService.sentOtp(_phoneNumber);
        isOtpSent = true;
        notifyListeners();
      } catch (e) {
        showException(e.toString());
      }
    } else {
      showException('Incorect phone number');
    }
  }

  void switchAutheticationClicked() {
    isLoginWithNumberClicked = !isLoginWithNumberClicked;
    notifyListeners();
  }

  void onApplyButtonClicked(
      {required Function(String message) showException}) async {
    bool isValid = _inputValidator.isOtpValid(_otpCode);
    if (isValid) {
      try {
        await _authService.loginWithOtp(otp: _otpCode);
        _localStorage.save(keyPhone, _phoneNumber);
      } catch (e) {
        showException("Incorect code. Please try again");
      }
    } else {
      showException('Code must have 6 numbers');
    }
  }

  void updatePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void updateOtpCode(String value) {
    _otpCode = value;
    notifyListeners();
  }
}
