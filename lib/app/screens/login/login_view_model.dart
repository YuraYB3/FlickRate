import 'package:flickrate/app/services/input_validator.dart';
import 'package:flutter/material.dart';
import '../../services/iauth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final IAuthService _authService;
  final InputValidator _inputValidator = InputValidator();
  String _phoneNumber = '';
  String _otpCode = '';
  bool isOtpSent = false;

  String get phoneNumber => _phoneNumber;
  String get otpCode => _otpCode;
  LoginViewModel({required IAuthService authService})
      : _authService = authService;

  void sentOtpClicked() async {
    bool isValid = _inputValidator.isNumberValid(_phoneNumber);
    if (isValid) {
      try {
        await _authService.sentOtp(_phoneNumber);
        isOtpSent = true;
        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("wrong number");
    }
  }

  void onApplyButtonClicked() async {
    bool isValid = _inputValidator.isOtpValid(_otpCode);
    if (isValid) {
      try {
        await _authService.loginWithOtp(otp: _otpCode);
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('Code wrong');
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
