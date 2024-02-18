import 'package:flickrate/app/services/iauth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'number_verification_view.dart';
import 'number_verification_view_model.dart';

class NumberVerificationFactory {
  static Widget build() {
    return ChangeNotifierProvider(
      create: (context) => NumberVerificationViewModel(
          authService: context.read<IAuthService>()),
      child: Consumer<NumberVerificationViewModel>(
        builder: (context, model, child) =>
            NumberVerificationView(model: model),
      ),
    );
  }
}
