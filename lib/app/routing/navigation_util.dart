import 'package:flutter/material.dart';

import 'inavigation_util.dart';

class NavigationUtil implements INavigationUtil {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigationUtil();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  bool get canPop => navigatorKey.currentState!.canPop();

  @override
  void navigateBack({data}) {
    navigatorKey.currentState!.pop(data);
  }

  @override
  void navigateBackToStart() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void navigateBackUntilNamed(String named) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(named));
  }

  @override
  Future navigateTo<T extends Object?>(String routeName,
      {bool allowBackNavigation = true, data}) {
    if (allowBackNavigation) {
      return navigatorKey.currentState!.pushNamed(routeName, arguments: data);
    } else {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: data);
    }
  }

  @override
  Future navigateToAndMakeRoot<T extends Object?>(String routeName, {data}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: data,
    );
  }

  @override
  Future navigateToAndReplace<T extends Object?>(String routeName, {data}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: data);
  }
}
