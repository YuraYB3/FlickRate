import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';

import '../../../domain/functions/ifunction_service.dart';

class FunctionService implements IFunctionService {
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  @override
  Future<dynamic> onCall(data, String functionName) async {
    HttpsCallable callable = functions.httpsCallable(functionName);
    try {
      var result = await callable.call(data);
      return result.data;
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }
}
