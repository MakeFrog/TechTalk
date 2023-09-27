import 'package:cloud_firestore/cloud_firestore.dart';

/** Created By Ximya - 2023.08.11
 *  FireStore Instance를 싱글톤으로 관리
 * */

abstract class FireStoreService {
  static final FirebaseFirestore _service = FirebaseFirestore.instance;
}
