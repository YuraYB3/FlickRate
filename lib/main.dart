import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/app/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/routing/app_router.dart';
import 'app/routing/inavigation_util.dart';
import 'app/routing/navigation_util.dart';
import 'app/services/auth/auth_service.dart';
import 'app/services/iuser_service.dart';
import 'app/services/user_service.dart';
import 'domain/auth/iauth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final INavigationUtil navigationUtil = NavigationUtil();
  final IAuthService authService = AuthService(
      firebaseAuth: FirebaseAuth.instance, navigationUtil: navigationUtil);
  final IUserService userService = UserService(authService: authService);

  runApp(MultiProvider(
    providers: [
      Provider.value(value: authService),
      Provider.value(value: navigationUtil),
      Provider.value(value: userService),
      ChangeNotifierProvider(
          create: (_) => HomeViewModel(userService: userService))
    ],
    child: App(
      userService: userService,
      appRouter: AppRouter(),
    ),
  ));
}
