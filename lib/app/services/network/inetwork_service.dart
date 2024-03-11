abstract interface class INetworkService {
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName);
  Future<void> create(Map<String, dynamic> data, String collectionName);
  Future<void> update(
      Map<String, dynamic> data, String collectionName, String documentId);
  Future<void> delete(String id, String collectionName);
  Stream<Map<String, dynamic>> read(String id, String collectionName);
}
