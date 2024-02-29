import 'package:cloud_functions/cloud_functions.dart';
import 'package:flickrate/app/services/functions/endpoints.dart';
import 'package:flickrate/app/services/functions/ifunction_service.dart';

class FunctionService implements IFunctionService {
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  @override
  Future<void> decreaseRating(String id) async {
    try {
      HttpsCallable callable = functions.httpsCallable(endpointDecreaseRating);
      print('id: $id');
      await callable.call({'movieId': id});
      print('Rating decremented successfully');
    } on FirebaseFunctionsException catch (e) {
      print('Error decremented rating: ${e.message}');
    }
  }

  @override
  Future<void> increaseRating(String id) async {
    try {
      HttpsCallable callable = functions.httpsCallable(endpointIncreaseRating);
      print('id: $id');
      await callable.call({'movieId': id});
      print('Rating incremented successfully');
    } on FirebaseFunctionsException catch (e) {
      print('Error incrementing rating: ${e.message}');
    }
  }
}
