import 'package:flickrate/app/routing/routes.dart';
import 'package:flutter/material.dart';

import 'routing/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenerateRoute,
      initialRoute: routeLogin,
    );
  }
}
