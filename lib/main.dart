// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/domain/local_notification/ilocal_notification_service.dart';
import 'package:flickrate/domain/notification/inotification_service.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/routing/app_router.dart';
import 'app/routing/inavigation_util.dart';
import 'app/routing/navigation_util.dart';
import 'app/services/user/iuser_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _initServices();
  final INavigationUtil navigationUtil = NavigationUtil();
  final ILocalNotificationService localNotificationService =
      locator<ILocalNotificationService>();
  final INotificationService notificationService =
      locator<INotificationService>();
  await localNotificationService.init();
  await notificationService.init();

  runApp(MultiProvider(
    providers: [
      Provider.value(value: navigationUtil),
    ],
    child: App(
      userService: locator<IUserService>(),
      appRouter: AppRouter(),
    ),
  ));
}

void _initServices() {
  initFunctionService();
  initPermissionHandler();
  initNetworkService();
  initStorageService();
  initLocalNotificationService();
  initNotificationService();
  initRepos();
  initAuthService();
  initUserService();
}

//TODO: Create likes and reviews count +
//TODO: Create reviews page
//TODO: Implement choose movie