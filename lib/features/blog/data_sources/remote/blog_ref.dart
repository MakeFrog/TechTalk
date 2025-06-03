import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

class FirestoreBlogRef {
  static const String _collection = 'Blogs';

  static CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection(_collection);

  static CollectionReference<BlogShellEntity> collection() {
    return _ref.withConverter(
      fromFirestore: BlogShellEntity.fromFirestore,
      toFirestore: (value, options) => value.toFirestore(),
    );
  }

  static DocumentReference<BlogShellEntity> doc(String id) {
    return collection().doc(id);
  }
}
