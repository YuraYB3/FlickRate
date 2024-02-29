import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/app/screens/home/home_view_model.dart';
import 'package:flickrate/app/services/functions/function_service.dart';
import 'package:flickrate/app/services/functions/ifunction_service.dart';
import 'package:flickrate/app/services/network/firebase_service.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/routing/app_router.dart';
import 'app/routing/inavigation_util.dart';
import 'app/routing/navigation_util.dart';
import 'app/services/auth/auth_service.dart';
import 'app/services/user/iuser_service.dart';
import 'app/services/user/user_service.dart';
import 'app/services/auth/iauth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final INavigationUtil navigationUtil = NavigationUtil();
  final IAuthService authService = AuthService(
      firebaseAuth: FirebaseAuth.instance, navigationUtil: navigationUtil);
  final IUserService userService = UserService(authService: authService);
  final INetworkService networkService = FirebaseService();
  final IFunctionService functionService = FunctionService();

  runApp(MultiProvider(
    providers: [
      Provider.value(value: authService),
      Provider.value(value: navigationUtil),
      Provider.value(value: userService),
      Provider.value(value: networkService),
      Provider.value(value: functionService),
      ChangeNotifierProvider(
        create: (_) => HomeViewModel(
          navigationUtil: navigationUtil,
        ),
      ),
    ],
    child: App(
      userService: userService,
      appRouter: AppRouter(),
    ),
  ));
}
