// ignore_for_file: avoid_print

import 'package:cloud_functions/cloud_functions.dart';

import 'ifunction_service.dart';

class FunctionService implements IFunctionService {
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  @override
  Future<void> onCall(data, String endPoint) async {
    try {
      HttpsCallable callable = functions.httpsCallable(endPoint);
      await callable.call(data);
    } on FirebaseFunctionsException catch (e) {
      print(e.message);
    }
  }
}
