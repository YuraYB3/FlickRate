import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/services/networking/inetwork_service.dart';
import 'app/services/networking/network_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final INetworkService networkService = NetworkService();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [Provider.value(value: networkService)],
    child: const App(),
  ));
}
