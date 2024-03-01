// ignore_for_file: avoid_print

import 'package:cloud_functions/cloud_functions.dart';

import 'endpoints.dart';
import 'ifunction_service.dart';

class FunctionService implements IFunctionService {
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  @override
  Future<void> decreaseRating(String id) async {
    try {
      HttpsCallable callable = functions.httpsCallable(endpointDecreaseRating);
      await callable.call({'movieId': id});
    } on FirebaseFunctionsException catch (e) {
      print(e.message);
    }
  }

  @override
  Future<void> increaseRating(String id) async {
    try {
      HttpsCallable callable = functions.httpsCallable(endpointIncreaseRating);
      await callable.call({'movieId': id});
    } on FirebaseFunctionsException catch (e) {
      print(e.message);
    }
  }
}
