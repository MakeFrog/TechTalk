import 'package:firebase_storage/firebase_storage.dart';

/** Created By Ximya - 2023.08.11
 *  FireStorage Instance를 싱글톤으로 관리
 * */

abstract class FireStorageService {
  static final FirebaseStorage _service = FirebaseStorage.instance;
}
