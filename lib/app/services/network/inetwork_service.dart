import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flickrate/domain/ibase_model.dart';

abstract interface class INetworkService {
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName);
  Future<void> create(Map<String, dynamic> data, String collectionName);
  Future<void> update(IBaseModel model, String collectionName);
  Future<void> delete(IBaseModel model, String collectionName);
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      String id, String collectionName);
}
