import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/services/iauth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enter_otp_view.dart';
import 'enter_otp_view_model.dart';

class EnterOtpFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) =>
          EnterOtpViewModel(authService: context.read<IAuthService>()),
      child: Consumer<EnterOtpViewModel>(
          builder: (context, model, child) => EnterOtpView(
              navigationUtil: context.read<INavigationUtil>(), model: model)),
    );
  }
}
