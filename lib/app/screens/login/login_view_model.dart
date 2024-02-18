import 'package:flutter/material.dart';

import '../../routing/inavigation_util.dart';
import '../../routing/routes.dart';

class LoginViewModel extends ChangeNotifier {
  final INavigationUtil navigationUtil;

  LoginViewModel({required this.navigationUtil});

  void onSignInWithNumberButtonPressed() {
    navigationUtil.navigateTo(routeNumber, allowBackNavigation: true);
  }
}
