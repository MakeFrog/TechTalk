import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/tech_set/data_source/remote/model/skill_model.dart';

abstract class FirestoreSkillRef {
  static const String _name = 'Skill';

  static CollectionReference<SkillModel> collection() =>
      FirebaseFirestore.instance.collection(_name).withConverter(
            fromFirestore: SkillModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<SkillModel> document(String channelId) =>
      FirebaseFirestore.instance.collection(_name).doc(channelId).withConverter(
            fromFirestore: SkillModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
