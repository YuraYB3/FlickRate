import 'package:flickrate/app/services/iauth_service.dart';
import 'package:flutter/material.dart';

class EnterOtpViewModel extends ChangeNotifier {
  final IAuthService authService;
  EnterOtpViewModel({required this.authService});

  void onApplyButtonClicked() async {
    await authService.loginWithOtp(otp: '123456');
  }
}
