import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/widgets/my_error_widget.dart';
import 'common/widgets/my_loading_widget.dart';
import 'routing/app_router.dart';
import 'routing/inavigation_util.dart';
import 'screens/core_navigation/core_navigation_factory.dart';
import 'screens/login/login_factory.dart';
import 'services/user/iuser_service.dart';
import 'services/user/user_service.dart';

class App extends StatefulWidget {
  final AppRouter _appRouter;
  final IUserService _userService;
  const App({
    Key? key,
    required IUserService userService,
    required AppRouter appRouter,
  })  : _appRouter = appRouter,
        _userService = userService,
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
      home: StreamBuilder<UserState>(
        stream: widget._userService.userStateStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: MyLoadingWidget());
          } else {
            if (snapshot.hasError) {
              return const Scaffold(body: MyErrorWidget());
            }
            switch (snapshot.data) {
              case UserState.notAuthorized:
                return LoginFactory.build();
              case UserState.readyToWork:
                return CoreNavigationFactory.build();
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
