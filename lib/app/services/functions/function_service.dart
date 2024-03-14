// ignore_for_file: avoid_print

import 'package:cloud_functions/cloud_functions.dart';

import 'ifunction_service.dart';

class FunctionService implements IFunctionService {
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  @override
  Future<void> onCall(data, String functionName) async {
    HttpsCallable callable = functions.httpsCallable(functionName);
    await callable.call(data);
  }
}
