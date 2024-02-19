import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/app/app.dart';
import 'package:flickrate/app/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/routing/inavigation_util.dart';
import 'app/routing/navigation_util.dart';
import 'app/services/auth_service.dart';
import 'app/services/iauth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final INavigationUtil navigationUtil = NavigationUtil();
  await Firebase.initializeApp();
  final IAuthService authService = AuthService(
      firebaseAuth: FirebaseAuth.instance, navigationUtil: navigationUtil);

  runApp(MultiProvider(
    providers: [
      Provider.value(value: authService),
      Provider.value(value: navigationUtil),
    ],
    child: App(
      authService: authService,
      appRouter: AppRouter(),
    ),
  ));
}
