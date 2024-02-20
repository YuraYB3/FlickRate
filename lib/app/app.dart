import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routing/app_router.dart';
import 'routing/inavigation_util.dart';
import 'screens/home/home_factory.dart';
import 'screens/login/login_factory.dart';
import '../domain/auth/iauth_service.dart';

class App extends StatefulWidget {
  final IAuthService _authService;
  final AppRouter _appRouter;
  const App({
    Key? key,
    required IAuthService authService,
    required AppRouter appRouter,
  })  : _authService = authService,
        _appRouter = appRouter,
        super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: context.read<INavigationUtil>().navigatorKey,
      onGenerateRoute: widget._appRouter.onGenerateRoute,
      home: StreamBuilder<AuthState>(
        stream: widget._authService.authState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }
            switch (snapshot.data) {
              case AuthState.unauthorized:
                return LoginFactory.build();
              case AuthState.authorized:
                return HomeFactory.build();
              default:
                return const Scaffold(
                  body: Center(
                    child: Text(
                      'default',
                      style: TextStyle(color: Colors.black, fontSize: 36),
                    ),
                  ),
                );
            }
          }
        },
      ),
    );
  }
}
