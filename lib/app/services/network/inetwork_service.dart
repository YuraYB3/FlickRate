import '../../../domain/ibase_model.dart';

abstract interface class INetworkService {
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName);
  Future<void> create(Map<String, dynamic> data, String collectionName);
  Future<void> update(IBaseModel model, String collectionName);
  Future<void> delete(String id, String collectionName);
  Stream<Map<String, dynamic>> read(String id, String collectionName);
}
