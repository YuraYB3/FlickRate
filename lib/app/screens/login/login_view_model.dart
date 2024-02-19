import 'package:flutter/material.dart';

import '../../routing/inavigation_util.dart';
import '../../services/iauth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final INavigationUtil navigationUtil;
  final IAuthService authService;
  bool isOtpSent = false;

  LoginViewModel({required this.authService, required this.navigationUtil});

  void sentOtpClicked() async {
    await authService.sentOtp();
    isOtpSent = true;
    notifyListeners();
  }

  void onApplyButtonClicked() async {
    await authService.loginWithOtp(otp: '123456');
  }
}
