import 'package:firebase_auth/firebase_auth.dart';
import 'package:flickrate/app/routing/inavigation_util.dart';
import 'package:flickrate/app/routing/routes.dart';
import 'package:flickrate/app/services/iauth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routing/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<IAuthService>().firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
          );
        } else if (snapshot.hasData) {
          return const _AppContent(route: routeHome);
        } else if (snapshot.hasData == false) {
          return const _AppContent(route: routeLogin);
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        return const Placeholder();
      },
    );
  }
}

class _AppContent extends StatelessWidget {
  final String route;
  const _AppContent({required this.route, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenerateRoute,
      navigatorKey: context.read<INavigationUtil>().navigatorKey,
      initialRoute: route,
    );
  }
}
