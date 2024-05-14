import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/screens/my_error_widget.dart';
import 'common/widgets/my_loading_widget.dart';
import 'routing/app_router.dart';
import '../domain/navigation/inavigation_util.dart';
import 'screens/core_navigation/core_navigation_factory.dart';
import 'screens/login/login_factory.dart';
import 'services/deep_linking/uni_services.dart';
import '../domain/user_service/iuser_service.dart';
import 'services/user/user_service.dart';

class App extends StatefulWidget {
  final AppRouter _appRouter;
  final IUserService _userService;
  final UniService _uniService;
  const App(
      {super.key,
      required IUserService userService,
      required AppRouter appRouter,
      required UniService uniService})
      : _appRouter = appRouter,
        _userService = userService,
        _uniService = uniService;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void didChangeDependencies() {
    widget._uniService.getInitialLink();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget._userService.closeUserStreamController();
    super.dispose();
  }

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
            return const Scaffold(body: MyLoadingScreen());
          } else {
            if (snapshot.hasError) {
              return const Scaffold(body: MyErrorScreen());
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
