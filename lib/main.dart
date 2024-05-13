import 'package:firebase_core/firebase_core.dart';
import 'package:flickrate/app/services/deep_linking/uni_services.dart';
import 'package:flickrate/firebase_options.dart';
import 'package:flickrate/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'app/routing/app_router.dart';
import 'domain/navigation/inavigation_util.dart';
import 'domain/user_service/iuser_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  runApp(MultiProvider(
    providers: [
      Provider.value(value: locator<INavigationUtil>()),
    ],
    child: App(
      userService: locator<IUserService>(),
      uniService: locator<UniService>(),
      appRouter: AppRouter(),
    ),
  ));
}
