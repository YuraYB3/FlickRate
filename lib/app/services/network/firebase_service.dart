import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flickrate/app/services/network/inetwork_service.dart';
import 'package:flickrate/domain/ibase_model.dart';

class FirebaseService implements INetworkService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<void> create(Map<String, dynamic> data, String collectionName) async =>
      await _firebaseFirestore.collection(collectionName).add(data);

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      IBaseModel model, String collectionName) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection(collectionName)
        .where('id', isEqualTo: model.id)
        .get();
    return querySnapshot.docs.first;
  }

  @override
  Future<void> update(IBaseModel model, String collectionName) async =>
      await _firebaseFirestore
          .collection(collectionName)
          .doc(model.id)
          .update(model.toJson());

  @override
  Future<void> delete(IBaseModel model, String collectionName) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection(collectionName)
        .where('id', isEqualTo: model.id)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName) =>
      _firebaseFirestore
          .collection(collectionName)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
