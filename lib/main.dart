// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'app/routing/app_router.dart';
import 'app/routing/inavigation_util.dart';
import 'app/services/user/iuser_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _initServices();
  final INavigationUtil navigationUtil = locator<INavigationUtil>();
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
  initNavigationService();
  initLocalNotificationService();
  initNotificationService();
  initRepos();
  initAuthService();
  initUserService();
}

//TODO: Create likes and reviews count +
//TODO: Create reviews page
//TODO: Implement choose movie

