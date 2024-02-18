import 'package:flickrate/app/services/iauth_service.dart';
import 'package:flutter/material.dart';

class NumberVerificationViewModel extends ChangeNotifier {
  final IAuthService authService;
  NumberVerificationViewModel({required this.authService});

  void sentOtpClicked() async {
    await authService.sentOtp();
  }
}
