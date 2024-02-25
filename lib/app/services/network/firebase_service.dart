import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flickrate/domain/ibase_model.dart';

class FirebaseService implements INetworkService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  @override
  Future<void> create(IBaseModel model, String collectionName) async =>
      await _firebaseFirestore.collection(collectionName).add(model.toJson());

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
          String id, String collectionName) async =>
      await _firebaseFirestore.collection(collectionName).doc(id).get();

  @override
  Future<void> update(IBaseModel model, String collectionName) async =>
      await _firebaseFirestore
          .collection(collectionName)
          .doc(model.id)
          .update(model.toJson());

  @override
  Future<void> delete(String id, String collectionName) async =>
      await _firebaseFirestore.collection(collectionName).doc(id).delete();

  @override
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName) =>
      _firebaseFirestore
          .collection(collectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
