import 'package:firebase_storage/firebase_storage.dart';

/** Created By Ximya - 2023.08.11
 *  FireStorage Instance를 싱글톤으로 관리
 * */

abstract class AppFireStorage {
  AppFireStorage._();

  static final FirebaseStorage _db = FirebaseStorage.instance;

  static FirebaseStorage get getInstance => _db;
}
