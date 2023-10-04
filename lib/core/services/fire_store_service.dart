import 'package:cloud_firestore/cloud_firestore.dart';

/** Created By Ximya - 2023.08.11
 *  FireStore Instance를 싱글톤으로 관리
 * */

enum FireStoreCollection {
  users,
}

abstract class FireStoreService {
  static final FirebaseFirestore _service = FirebaseFirestore.instance;

  static Future<CollectionReference<Map<String, dynamic>>> getCollection<T>(
      FireStoreCollection collection) async {
    return _service.collection(collection.name);
  }
}
