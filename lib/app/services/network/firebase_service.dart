import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/network/inetwork_service.dart';

class FirebaseService implements INetworkService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<void> create(Map<String, dynamic> data, String collectionName) async {
    DocumentReference docRef =
        await _firebaseFirestore.collection(collectionName).add(data);
    String docId = docRef.id;
    await docRef.update({'documentId': docId});
  }

  @override
  Stream<Map<String, dynamic>> read(String id, String collectionName) {
    return _firebaseFirestore
        .collection(collectionName)
        .doc(id)
        .snapshots()
        .map((event) => event.data()!);
  }

  @override
  Future<void> update(Map<String, dynamic> data, String collectionName,
      String documentId) async {
    await _firebaseFirestore
        .collection(collectionName)
        .doc(documentId)
        .update(data);
  }

  @override
  Future<void> delete(String id, String collectionName) async {
    await _firebaseFirestore.collection(collectionName).doc(id).delete();
  }

  @override
  Stream<List<Map<String, dynamic>>> fetchDataStream(String collectionName) =>
      _firebaseFirestore.collection(collectionName).snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
          );
}
