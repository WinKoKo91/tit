import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConfigService extends GetxService {
  final firebaseFireStore = FirebaseFirestore.instance;

  Future<void> updateFireStoreData(
      {required String collectionPath,
      String? path,
      required Map<String, dynamic> updateData}) async {
    return await firebaseFireStore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFireStoreData(
      {required String collectionPath, SearchEntity? searchEntity}) {
    
    if (searchEntity == null) {
      return firebaseFireStore.collection(collectionPath).snapshots();
    } else {
      return firebaseFireStore
          .collection(collectionPath)
          .where(searchEntity.key, isEqualTo: searchEntity.text)
          .snapshots();
    }
    
  }

  Future<void> addFireStoreData(
      {required String collectionPath,
      String? path,
      required Map<String, dynamic> updateData}) async {
    
    return await firebaseFireStore
        .collection(collectionPath)
        .doc(path)
        .set(updateData);
  }

  Future<void> deleteFireStoreData(
      {required String collectionPath,
      String? path,
      required Map<String, dynamic> updateData}) async {
    
    return await firebaseFireStore
        .collection(collectionPath)
        .doc(path)
        .delete();
  }
}

class SearchEntity {
  final String key;
  final String text;

  SearchEntity({required this.key, required this.text});
}
