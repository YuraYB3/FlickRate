import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/app/app.dart';
import 'package:flickrate/app/routing/app_router.dart';
import 'package:flickrate/app/services/iuser_service.dart';
import 'package:flickrate/app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/routing/inavigation_util.dart';
import 'app/routing/navigation_util.dart';
import 'app/services/auth/auth_service.dart';
import 'app/services/local_storage/local_storage.dart';
import 'domain/auth/iauth_service.dart';
import 'domain/local_storage/ilocal_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final INavigationUtil navigationUtil = NavigationUtil();
  final ILocalStorage localStorage = LocalStorage();
  await Firebase.initializeApp();
  final IAuthService authService = AuthService(
      firebaseAuth: FirebaseAuth.instance, navigationUtil: navigationUtil);
  final IUserService userService =
      UserService(authService: authService, localStorage: localStorage);

  runApp(MultiProvider(
    providers: [
      Provider.value(value: authService),
      Provider.value(value: navigationUtil),
      Provider.value(value: localStorage),
      Provider.value(value: userService)
    ],
    child: App(
      authService: authService,
      appRouter: AppRouter(),
    ),
  ));
}
