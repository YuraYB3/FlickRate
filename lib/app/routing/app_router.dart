import 'package:flickrate/app/screens/login/number_verification/number_verification_factory.dart';
import 'package:flutter/material.dart';

import '../screens/home/home_factory.dart';
import '../screens/login/enter_otp/enter_otp_factory.dart';
import '../screens/login/login_factory.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeLogin:
        return MaterialPageRoute(
            builder: (_) => _buildLoginSettings(routeSettings));
      case routeHome:
        return MaterialPageRoute(
            builder: (_) => _buildHomeSettings(routeSettings));
      case routeNumber:
        return MaterialPageRoute(
            builder: (_) => _buildNumberSettings(routeSettings));
      case routeEnterOtp:
        return MaterialPageRoute(
            builder: (_) => _buildEnterOtpSettings(routeSettings));
      default:
    }
    return null;
  }

  Widget _buildLoginSettings(RouteSettings settings) {
    return LoginFactory.build();
  }

  Widget _buildNumberSettings(RouteSettings settings) {
    return NumberVerificationFactory.build();
  }

  Widget _buildEnterOtpSettings(RouteSettings settings) {
    return EnterOtpFactory.build();
  }

  Widget _buildHomeSettings(RouteSettings settings) {
    return HomeFactory.build();
  }
}
