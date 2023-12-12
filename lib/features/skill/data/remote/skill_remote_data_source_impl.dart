import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/skill/data/models/skill_list_model.dart';
import 'package:techtalk/features/skill/data/models/skill_model.dart';
import 'package:techtalk/features/skill/skill.dart';

class SkillRemoteDataSourceImpl implements SkillRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<SkillModel> get _skillCollection =>
      _firestore.collection(FirestoreCollection.skills.name).withConverter(
            fromFirestore: (snapshot, _) => SkillModel.fromFirestore(snapshot),
            toFirestore: (value, _) => value.toJson(),
          );

  @override
  Future<SkillListModel> getSkillsByKeyword(String keyword) async {
    final snapshot = await _skillCollection
        .orderBy('name')
        .where(
          'name',
          isGreaterThanOrEqualTo: keyword,
        )
        .where(
          'name',
          isLessThanOrEqualTo: '$keyword~',
        )
        .get();

    final skills = snapshot.docs
        .map(
          (e) => e.data(),
        )
        .toList();

    return SkillListModel(
      totalCount: snapshot.size,
      skills: skills,
    );
  }
}
